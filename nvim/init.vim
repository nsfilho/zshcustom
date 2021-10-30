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
set wrap
set cmdheight=2
set updatetime=300
set shortmess+=c
set cursorline
set pyx=3
let mapleader=","
set signcolumn=yes
set completeopt=menu,menuone,noselect

setlocal colorcolumn=120
set spelllang=en,pt
set spell!
let g:netrw_http_cmd = "wget"
let g:vscode_style = "dark"
" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
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

" colorscheme dracula
" colorscheme vscode
colorscheme ayu
" hi LspDiagnosticsUnderlineError guifg=NONE
