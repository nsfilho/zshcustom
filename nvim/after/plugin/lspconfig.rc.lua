local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end

local statusNavic, navic = pcall(require, "nvim-navic")

local protocol = require("vim.lsp.protocol")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- if you want to set up formatting on save, you can use this as a callback
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
    buf_set_keymap("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { silent = true })
    buf_set_keymap("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { silent = true })
    buf_set_keymap("n", "<leader>cs", ":Lspsaga signature_help<CR>", { silent = true })
    buf_set_keymap("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", { silent = true })
    buf_set_keymap("n", "<leader>cn", ":Lspsaga diagnostic_jump_next<CR>", { silent = true })
    buf_set_keymap("n", "<leader>cp", ":Lspsaga diagnostic_jump_prev<CR>", { silent = true })
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
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    -- buf_set_keymap("n", "<leader>q", ":Telescope diagnostics<CR>", opts)
    buf_set_keymap("n", "<leader>q", ":TroubleToggle<CR>", opts)
    buf_set_keymap("n", "<leader>so", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format { async = false }<CR>", opts)

    if (statusNavic) then
        navic.attach(client, bufnr)
    end
end

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
    ["rust_analyzer"] = function()
        lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
            settings = {
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
            },
        }
    end,
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
