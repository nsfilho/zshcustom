
require("telescope").load_extension "file_browser"

require('telescope').setup { 
    extensions = {
        file_browser = {
            theme = "ivy",
        },
    },
    defaults = { 
        file_ignore_patterns = {
            'node_modules',
            '.git/'
        }, 
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
        },
    },
    pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
            -- sort_mru = true,
            mappings = {
                 i = {
                   ["<c-d>"] = require("telescope.actions").delete_buffer,
                   -- or right hand side can also be a the name of the action as string
                   -- ["<c-a>"] = function() vim.cmd ":norm I" end,
                   -- ["<c-e>"] = function() vim.cmd ":norm A" end,
                   -- ["<c-u>"] = function() vim.cmd ":norm c0" end,
                 },
                 n = {
                   ["<c-d>"] = require("telescope.actions").delete_buffer,
                 }
            }
        }
    }
}

