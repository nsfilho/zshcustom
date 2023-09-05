local status, cmp = pcall(require, "cmp")
if (not status) then return end

local statusKind, lspkind = pcall(require, "lspkind")
if (not statusKind) then return end

-- nvim-cmp setup
local source_mapping = {
    nvim_lsp = "🔨",
    nvim_lua = "🛸",
    buffer = "🔖",
    cmp_tabnine = "🔦",
    path = "🗂️",
    spell = "💬",
    calc = "🔢",
    nvim_lsp_signature_help = "🖊️",
    cmdline = "👉"
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
        format = function(entry, vim_item)
            -- if you have lspkind installed, you can use it like
            -- in the following line:
            vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
            vim_item.menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                local detail = (entry.completion_item.data or {}).detail
                vim_item.kind = ""
                if detail and detail:find('.*%%.*') then
                    vim_item.kind = vim_item.kind .. ' ' .. detail
                end

                if (entry.completion_item.data or {}).multiline then
                    vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                end
            end
            local maxwidth = 80
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        -- ["<A-e"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        -- ["<Tab>"] = function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     else
        --         fallback()
        --     end
        -- end,
        -- ["<S-Tab>"] = function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     else
        --         fallback()
        --     end
        -- end
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "neorg"},
        { name = "path" },
        { name = "vsnip" },
        { name = "cmp_tabnine" },
        { name = "emoji" },
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
