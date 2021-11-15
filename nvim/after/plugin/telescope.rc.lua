
require('telescope').setup { 
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
        }
    }
}

