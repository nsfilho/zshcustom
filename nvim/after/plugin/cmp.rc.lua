---@diagnostic disable: need-check-nil
local status, cmp = pcall(require, "cmp")
if (not status) then return end

local statusKind, lspkind = pcall(require, "lspkind")
if (not statusKind) then return end

-- nvim-cmp setup
local source_mapping = {
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    buffer = "[Buffer]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
    spell = "[Spell]",
    calc = "[Calc]",
    nvim_lsp_signature_help = "[Signature]",
    cmdline = "[Command]"
}

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
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            before = function(entry, vim_item)
                local menu = source_mapping[entry.source.name]
                if entry.source.name == "cmp_tabnine" then
                    if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                        menu = entry.completion_item.data.detail .. " " .. menu
                    end
                end
                vim_item.menu = menu
                return vim_item
            end
        })
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
        { name = "vsnip" },
        { name = "cmp_tabnine" },
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
        -- entries = { name = 'wildmenu', separator = '|' }
        entries = { name = 'custom' }
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    view = {
        -- entries = { name = 'wildmenu', separator = '|' }
        entries = { name = 'custom' }
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
