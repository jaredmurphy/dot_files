" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

" ========================================================================
" I took a bunch of this from Bryan Mytko (https://github.com/bryanmytko/dot_files)
" ========================================================================

" ========================================================================
" Defaults
" ========================================================================
let mapleader = ","
set nocompatible
filetype indent on
syntax enable
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set formatoptions-=cro
set t_Co=256
set number
set autoindent
set hlsearch
set autoread
set nopaste
set splitbelow
set splitright

" ========================================================================
" Plug
" ========================================================================
call plug#begin('~/.vim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'scrooloose/nerdcommenter'
Plug 'garbas/vim-snipmate'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'janko/vim-test'
Plug 'editorconfig/editorconfig-vim'
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-system-copy'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Install https://github.com/neoclide/coc-solargraph for ruby

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'mxw/vim-jsx'
Plug 'isRuslan/vim-es6'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

call plug#end()

" Ctrlp
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules/'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:50,results:50'
map <leader>m :CtrlPMRU<CR>
map <leader>b :CtrlPBuffer<CR>

" Nerdtree
map <leader>n :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Ale
let g:ale_sign_error = '●'
let g:ale_sign_warning = '•'
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = {
\   'typescript': ['prettier'],
\   'ruby': ['rubocop'],
\}

" Vim-Test
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" lets vim-jsx run on .js files
let g:jsx_ext_required = 0

" ========================================================================
" Mappings
" ========================================================================
imap jj <Esc>

nmap <silent> <C-e> <Plug>(ale_next_wrap)

" make it easier to switch between windows
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" make it easier to manage tabs
nnoremap <C-t> :tabnew<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT

" copy filename to clipboard
nnoremap <leader>F :!echo -n % \| pbcopy<CR><CR>

" format entire file and return to line
nnoremap fo gg=G''

" switch between the last 2 files
nnoremap <leader><Space> <c-^>

" clear the search buffer with return
nnoremap <CR> :nohlsearch<cr>

" use <leader>sc to reload buffer with updated vimrc
nnoremap <leader>sc :source ~/.vimrc<CR>

" ========================================================================
" Functions
" ========================================================================

" COC use tab
function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" map ctrl-j and ctrl-k to up/down in completion options
inoremap <expr> <C-J> ((pumvisible())?("\<C-n>"):("\<C-J>"))
inoremap <expr> <C-K> ((pumvisible())?("\<C-p>"):("\<C-K>"))

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rename current file (thanks Gary Bernhardt)
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
" Promote variable to Rspec let (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  ":exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO: INPROGRESS
" do/end block to {} block
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! PromoteToCurly()
  :normal! dd
  :normal! P
  ":.s/\(\w\+\) { \(.*\)$/do\1 new_line \2 end/
  ":.s/\(\w\+\) { \(.*\)$/\1 do \r now im here/

  ":.s/\ { \(.*\)$/ do \r \1/

  ":normal j

  :.s/\ } \(.*\)$/ \1 \r end/
  :normal ==
endfunction
:command! PromoteToCurly :call PromoteToCurly()
:map <leader>do :PromoteToCurly<cr>

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
" OpenChangedFiles COMMAND thanks Gary
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "vsp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch between test and production code (thanks Gary)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<workers\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1  || match(current_file, '\<services\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

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

" remove whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" close quickfix window when selecting an item
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" Make quickfix window taller ----- ????
au FileType qf call AdjustWindowHeight(10, 25)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" ========================================================================
" Display
" ========================================================================
set list listchars=tab:>-,trail:•,precedes:<,extends:>
set list
hi MatchParen cterm=none ctermbg=black ctermfg=yellow
set formatoptions-=ro
set background=dark
colorscheme gruvbox
set background=dark
:hi Comment ctermfg=DarkMagenta
set colorcolumn=108
highlight ColorColumn ctermbg=0 guibg=lightgrey

" ========================================================================
" Other
" ========================================================================
" make sure to not rename original files - will mess up webpack watch
set backupcopy=yes
" do not store global and local values in a session
set ssop-=options
