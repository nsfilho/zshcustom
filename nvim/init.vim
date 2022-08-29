set mouse=a
set hidden
set relativenumber
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
set cmdheight=1
set updatetime=300
set shortmess+=c
set cursorline
set pyx=3
let mapleader=","
set signcolumn=yes
set completeopt=menu,menuone,noselect

" set cursorcolumn modes
augroup cursor_nvim
    autocmd InsertEnter * set cursorcolumn
    autocmd InsertLeave * set nocursorcolumn
augroup END

" set nofoldenable
augroup filetype_vim
    autocmd!
    autocmd BufRead,BufNewFile *.json set filetype=jsonc
    autocmd FileType yaml,go,rust,java,c,typescript,javascript,typescriptreact,javascriptreact setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldlevel=99
    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
augroup END


setlocal colorcolumn=120
set spelllang=en,pt
" set spell!
let g:netrw_http_cmd = "wget"
let g:vscode_style = "dark"
let g:tokyonight_style = "night"
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

if (has("termguicolors"))
 set termguicolors
endif

runtime ./plugins.vim
runtime ./maps.vim
runtime ./macos.vim
runtime ./others.vim

colorscheme tokyonight
" colorscheme dracula
" colorscheme vscode
" colorscheme ayu
" hi LspDiagnosticsUnderlineError guifg=NONE
