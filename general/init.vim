call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jacoborus/tender.vim'
Plug 'joshdick/onedark.vim'
Plug 'haishanh/night-owl.vim'
Plug 'kaicataldo/material.vim'
Plug 'hzchirs/vim-material'
Plug 'vim-airline/vim-airline'
" Plug 'camspiers/animate.vim'
" Plug 'camspiers/lens.vim'
Plug 'plasticboy/vim-markdown'
Plug 'majutsushi/tagbar'
" Plug 'liuchengxu/vista.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/gv.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
call plug#end()

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
set signcolumn=yes
set clipboard+=unnamedplus
set nowrap
set cmdheight=2
set shortmess+=c
set cursorline
set pyx=3
" set cursorcolumn
let mapleader=","

if (has("termguicolors"))
 set termguicolors
endif

" Colorscheme definitions
" colorscheme gruvbox
colorscheme dracula
" colorscheme material

" set background=dark
" let g:material_style='oceanic'
" let g:airline_theme='material'
" colorscheme vim-material

" General definitions
let g:NERDTreeShowHidden = 1
let g:rainbow_active = 1
let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:indentLine_setConceal = 0
" let g:vista_fzf_preview = ['right:50%']
" let g:vista#renderer#enable_icon = 1
 
" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-highlight',
  \ 'coc-tag',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-lists',
  \ 'coc-yaml',
  \ 'coc-syntax',
  \ 'coc-git',
  \ 'coc-emoji',
  \ 'coc-calc',
  \ 'coc-xml',
  \ 'coc-marketplace',
  \ 'coc-webpack',
  \ 'coc-word',
  \ 'coc-lines',
  \ 'coc-markdownlint',
  \ 'coc-vimlsp',
  \ 'coc-ecdict',
  \ 'coc-clangd',
  \ 'coc-import-cost'
  \ ]


" TagBar
" let g:tagbar_width = 40
" let g:tagbar_iconchars = ['↠', '↡']

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd FileType markdown,typescript,json,jsonc set conceallevel=0
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" function! NearestMethodOrFunction() abort
"   return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" 
" set statusline+=%{NearestMethodOrFunction()}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" Resize Window
" nnoremap <silent> <S-Up>    :call animate#window_delta_height(10)<CR>
" nnoremap <silent> <S-Down>  :call animate#window_delta_height(-10)<CR>
" nnoremap <silent> <S-Left>  :call animate#window_delta_width(10)<CR>
" nnoremap <silent> <S-Right> :call animate#window_delta_width(-10)<CR>

" Others Shortcuts
" autocmd vimenter * Tagbar
" autocmd vimenter * NERDTree

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <F2> <Plug>(coc-rename)
nnoremap ¬ :bnext<CR>
nnoremap ˙ :bprev<CR>
nnoremap <C-x> :bd<CR>


" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()
" Auto-close nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <silent> <leader>w :set wrap! wrap?<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F7> :call SyncTree()<CR>
"nmap <F8> :Vista!!<CR>
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>s :CocCommand snippets.editSnippets<CR>
nnoremap <leader>c :close<CR>

" Navigate neovim + neovim terminal emulator with alt+direction
tnoremap <silent><C-h> <C-\><C-n><C-w>h
tnoremap <silent><C-j> <C-\><C-n><C-w>j
tnoremap <silent><C-k> <C-\><C-n><C-w>k
tnoremap <silent><C-l> <C-\><C-n><C-w>l

" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

