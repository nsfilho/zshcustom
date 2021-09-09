
require('telescope').setup { 
    defaults = { 
        file_ignore_patterns = {
            'node_modules'
        }, 
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--hidden',
          '--line-number',
          '--column',
          '--smart-case'
        } 
    } 
}

