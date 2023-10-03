local lint_ok, lint = pcall(require, "lint")
if (not lint_ok) then return end

lint.linters_by_ft = {
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function()
        lint.try_lint()
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        lint.try_lint()
    end,
})
