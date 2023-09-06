local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

-- Check if directory /usr/local/Cellar/gcc/13.2.0/bin
if (vim.fn.isdirectory("/usr/local/Cellar/gcc/13.2.0/bin") == 1) then
    require("nvim-treesitter.install").compilers = { "gcc-13" }
end

ts.setup {
    ensure_installed = { "bash", "c", "cpp", "css", "dockerfile", "gitignore", "html", "java", "javascript", "json",
        "lua", "make", "markdown", "rust", "scss", "toml", "typescript", "tsx", "yaml" },
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    autotag = {
        enable = true,
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
