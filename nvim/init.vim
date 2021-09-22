set mouse=a
set hidden
" set relativenumber
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set matchpairs+=<:>
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set ttyfast
set splitbelow
set splitright
set nowrap
set cmdheight=2
set updatetime=300
set shortmess+=c
set cursorline
set pyx=3
let mapleader=","
set signcolumn=yes
set completeopt=menuone,noselect
let g:nvim_tree_hijack_cursor = 0
let g:nvim_tree_lsp_diagnostics = 1
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:completion_confirm_key = ""
let g:completion_chain_complete_list = {
        \ 'default' : {
        \   'default': [
        \       {'complete_items': ['lsp', 'snippet', 'path']},
        \       {'mode': '<c-p>'},
        \       {'mode': '<c-n>'}],
        \   'comment': []
        \   }
        \}

let g:dashboard_default_executive = 'telescope'

if (has("termguicolors"))
 set termguicolors
endif

runtime ./plugins.vim
runtime ./maps.vim
runtime ./macos.vim
runtime ./others.vim

colorscheme dracula

