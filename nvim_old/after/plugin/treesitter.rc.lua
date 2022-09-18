require('nvim-treesitter.configs').setup {
    ensure_installed = { "bash", "c", "cpp", "css", "dockerfile", "gitignore", "html", "java", "javascript", "json", "lua", "make", "markdown", "rust", "scss", "toml", "typescript", "tsx", "yaml" },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
}
