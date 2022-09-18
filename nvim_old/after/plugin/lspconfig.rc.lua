require("lspconfig")
local protocol = require("vim.lsp.protocol")

local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    local opts = { noremap = true, silent = true }

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- buf_set_keymap("n", "<leader>ca", ":Telescope lsp_code_actions<CR>", opts)
    buf_set_keymap("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
    buf_set_keymap(
        "n",
        "<leader>e",
        ":Lspsaga show_line_diagnostics<CR>",
        opts
    )
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>q", ":Telescope diagnostics<CR>", opts)
    buf_set_keymap(
        "n",
        "<leader>so",
        [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
        opts
    )
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
end

-- local ih = require("inlay-hints")
-- ih.setup();
local navic = require("nvim-navic");
navic.setup();
require('Comment').setup()

local capabilities = protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = function (c, b)
            navic.attach(c, b)
            on_attach(c, b)
        end,
        capabilities = capabilities,
    }
    if server.name == "rust_analyzer" then
        opts.on_attach = function(c, b)
            navic.attach(c, b)
            -- ih.on_attach(c, b)
            on_attach(c, b)
        end
        opts.settings = {
            ["rust-analyzer"] = {
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
        }
    end
    if server.name == "tsserver" or server.name == "jsonls" then
        opts.on_attach = function(c, b)
            c.resolved_capabilities.document_formatting = false
            c.resolved_capabilities.document_range_formatting = false
            -- ih.on_attach(c, b)
            navic.attach(c, b)
            on_attach(c, b)
        end
        --        opts.settings = {
        --            javascript = {
        --                inlayHints = {
        --                    includeInlayEnumMemberValueHints = true,
        --                    includeInlayFunctionLikeReturnTypeHints = true,
        --                    includeInlayFunctionParameterTypeHints = true,
        --                    includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        --                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        --                    includeInlayPropertyDeclarationTypeHints = true,
        --                    includeInlayVariableTypeHints = true,
        --                },
        --            },
        --            typescript = {
        --                inlayHints = {
        --                    includeInlayEnumMemberValueHints = true,
        --                    includeInlayFunctionLikeReturnTypeHints = true,
        --                    includeInlayFunctionParameterTypeHints = true,
        --                    includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        --                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        --                    includeInlayPropertyDeclarationTypeHints = true,
        --                    includeInlayVariableTypeHints = true,
        --                },
        --            },
        --        }
    end
    server:setup(opts)
end)

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
    default_timeout = 10000,
    debug = false,
    sources = {
        --        null_ls.builtins.diagnostics.eslint.with({
        --            prefer_local = "node_modules/.bin",
        --        }),
        --        null_ls.builtins.code_actions.eslint.with({
        --            prefer_local = "node_modules/.bin",
        --        }),
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin",
        }),
        null_ls.builtins.completion.vsnip,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        signs = true,
        virtual_text = {
            spacing = 4,
            prefix = ""
        }
    }
)

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

-- nvim-cmp setup
local lspkind = require("lspkind")

local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
    spell = "[Spell]",
    calc = "[Calc]",
}

local cmp = require "cmp"
cmp.setup {
    view = {
        entries = { name = 'custom', selection_order = 'near_cursor' }
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. " " .. menu
                end
                vim_item.kind = ""
            end
            vim_item.menu = menu
            return vim_item
        end
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "calc" },
        { name = "cmp_tabnine" },
        { name = "vsnip" },
        { name = "spell" },
        {
            name = "buffer",
            option = {
                get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end
            },
        }
    }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    view = {
        entries = { name = 'custom' }
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})


-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
