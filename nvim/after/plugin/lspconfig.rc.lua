local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local mason_ok, mason = pcall(require, "mason")
local rt_ok, rt = pcall(require, "rust-tools")
local mason_lspconfig_ok, masonConfig = pcall(require, "mason-lspconfig")
local navic_ok, navic = pcall(require, "nvim-navic")

if not (lspconfig_ok and mason_ok and mason_lspconfig_ok) then
    error("O lspconfig ou mason não foram instalados")
    return
end

mason.setup({
    max_concurrent_installers = 1,
})

if (jit.arch ~= 'x64') then
    masonConfig.setup {
        ensure_installed = { "bashls", "tsserver", "html", "yamlls", "prettierd", "eslint_d" },
    }
else
    masonConfig.setup {
        ensure_installed = { "lua_ls", "rust_analyzer", "bashls", "tsserver", "html", "yamlls", "taplo", "prettierd",
            "eslint_d" },
    }
end



local protocol = require("vim.lsp.protocol")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local augroupFormatting = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap = true, silent = true }

    -- enable auto-completition by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- maps for lsp
    buf_set_keymap("n", "<leader>cf", ":Lspsaga finder<CR>", { silent = true })
    buf_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", { silent = true })
    buf_set_keymap("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>',
        { silent = true })
    buf_set_keymap("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>',
        { silent = true })
    buf_set_keymap("n", "<leader>cs", ":Lspsaga signature_help<CR>", { silent = true })
    buf_set_keymap("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", { silent = true })
    buf_set_keymap("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", { silent = true })
    buf_set_keymap("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", { silent = true })
    buf_set_keymap("n", "<leader>cr", ":Lspsaga rename<CR>", { silent = true })
    buf_set_keymap("n", "<leader>cd", ":Lspsaga preview_definition<CR>", { silent = true })
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
    buf_set_keymap("n", "<leader>e", ":Lspsaga show_line_diagnostics<CR>", opts)
    -- buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    -- buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    -- buf_set_keymap("n", "<leader>q", ":Telescope diagnostics<CR>", opts)
    buf_set_keymap("n", "<leader>q", ":TroubleToggle<CR>", opts)
    buf_set_keymap("n", "<leader>so", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format { async = false }<CR>", opts)

    if rt_ok then
        buf_set_keymap("n", "<Leader>ah", rt.hover_actions.hover_actions)
        buf_set_keymap("n", "<Leader>ac", rt.code_action_group.code_action_group)
    end

    if (navic_ok) then
        navic.attach(client, bufnr)
    end
end

-- check for rust dap adapter
local function rustdap()
    local mason_registry = require('mason-registry')
    local codelldb = mason_registry.get_package('codelldb')
    local extension_path = codelldb:get_install_path() .. "/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    return {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
    }
end

local rustdap_ok, rustdap = pcall(rustdap)
if not rustdap_ok then
    rustdap = {}
end

rt.setup({
    dap = rustdap,
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            check = {
                command = "clippy"
            },
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    },
    tools = {
        hover_actions = {
            auto_focus = true,
        },
    }
})

-- command to list server_capabilities: :lua =vim.lsp.get_active_clients()[1].server_capabilities
require("mason-lspconfig").setup_handlers({
    function(server_name)
        -- print("Auto setup lsp for:" .. server_name)
        lspconfig[server_name].setup {
            on_attach = on_attach,
        }
    end,
    ["html"] = function()
        lspconfig.html.setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
    end,
    ["tsserver"] = function()
        lspconfig.tsserver.setup {
            on_attach = on_attach,
            -- filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
            cmd = { "typescript-language-server", "--stdio" },
            capabilities = capabilities
        }
    end,
    -- ["rust_analyzer"] = function()
    --     lspconfig.rust_analyzer.setup {
    --         on_attach = on_attach,
    --         settings = {
    --             imports = {
    --                 granularity = {
    --                     group = "module",
    --                 },
    --                 prefix = "self",
    --             },
    --             cargo = {
    --                 buildScripts = {
    --                     enable = true,
    --                 },
    --             },
    --             procMacro = {
    --                 enable = true
    --             },
    --         },
    --     }
    -- end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup {
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false
                    },
                },
            },
        }
    end,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        update_in_insert = false,
        signs = true,
        virtual_text = {
            spacing = 4,
            prefix = ""
        },
        severity_sort = true,
    }
)

vim.diagnostic.config({
    virtual_text = {
        prefix = '●'
    },
    update_in_insert = true,
    float = {
        source = "always", -- Or "if_many"
    },
})
