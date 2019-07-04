" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

" ========================================================================
" I took a bunch of this from Bryan Mytko (https://github.com/bryanmytko/dot_files)
" ========================================================================

" ========================================================================
" Important
" ========================================================================
set nocompatible
filetype on
let mapleader = ","

" ========================================================================
" Vundle
" ========================================================================

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-surround'
Plugin 'janko-m/vim-test'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'isRuslan/vim-es6'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'garbas/vim-snipmate'
Plugin 'mileszs/ack.vim'

call vundle#end()

" ========================================================================
" Mappings
" ========================================================================
imap jj <Esc>

" ctrlp
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules/'

" make it easier to switch between windows
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" map <space> to :
nnoremap <space> :

" make it easier to copy to clipboard
noremap cp :w !pbcopy<CR><CR>

" format entire file and return to line
nnoremap fo gg=G''

" switch between the last 2 files
nnoremap <leader><leader> <c-^>

" clear the search buffer with return
nnoremap <CR> :nohlsearch<cr>

" use <leader>s to reload buffer with updated vimrc
nnoremap <leader>sc :source ~/.vimrc<CR>

" use <leader>e for :Explore
nnoremap <leader>e :Explore<Cr>

" user leader s for snipmate trigger
:imap <leader>s <Plug>snipMateNextOrTrigger
:smap <leader>s <Plug>snipMateNextOrTrigger

" map vim-test commands
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>

" emmet settings
let g:user_emmet_leader_key = "<Tab>"
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" lets vim-jsx run on .js files
let g:jsx_ext_required = 0

" use github style markdown
let vim_markdown_preview_github=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY (thanks Gary Bernhardt)
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" map ctrl-j and ctrl-k to up/down in completion options
inoremap <expr> <C-J> ((pumvisible())?("\<C-n>"):("\<C-J>"))
inoremap <expr> <C-K> ((pumvisible())?("\<C-p>"):("\<C-K>"))

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rename Current File (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

map <Leader>rn :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go back to same line when closing & reopening the buffer (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use ag instedad of grep (https://thoughtbot.com/blog/faster-grepping-in-vim)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" map K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" map \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" ========================================================================
" Display
" ========================================================================
" Handle ugly whitespace
set list listchars=tab:>-,trail:•,precedes:<,extends:>
set list

" Make it more obvious which paren I'm on
hi MatchParen cterm=none ctermbg=black ctermfg=yellow

if &term =~ '256color'
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

syntax on
set t_Co=256
set colorcolumn=100
set cursorline
set number
set tabstop=2
set shiftwidth=2
set smartindent
set autoindent
filetype indent on
set expandtab
set hlsearch
syntax on
colorscheme railscasts

" enable status line always
set laststatus=2

" make comments italicized
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
hi Comment cterm=italic gui=bold

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" mouse scroll
set mouse=a
set history=10000

set nopaste

" make sure to not rename original files - will mess up webpack watch
set backupcopy=yes

" reload file if is changed
set autoread

" remove whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" close quickfix window when selecting an item
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

