local conform_ok, conform = pcall(require, "conform")
if (not conform_ok) then return end

conform.setup({
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters_by_ft = {
        javascript = { { "prettierd" } },
        javascriptreact = { { "prettierd" } },
        typescript = { { "prettierd" } },
        typescriptreact = { { "prettierd" } },
    },
})
