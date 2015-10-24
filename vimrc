" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/dotfiles2/vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/dotfiles2/vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'Shougo/vimproc.vim', {
  \   'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \   }
  \ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim'
  \ }
NeoBundleLazy 'Shougo/vimfiler', {
  \ 'depends' : ["Shougo/unite.vim"],
  \ 'autoload' : {
  \   'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
  \   'mappings' : ['<Plug>(vimfiler_switch)'],
  \   'explorer' : 1,
  \ }}

NeoBundle 'myusuf3/numbers.vim'
NeoBundleLazy 'ConradIrwin/vim-bracketed-paste', {
  \ 'autoload' : { 'insert' : 1,}
  \ }

NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'scrooloose/syntastic'
NeoBundleLazy 'thinca/vim-quickrun', {
  \ 'autoload' : {
  \   'mappings' : [['n', '\r']],
  \   'commands' : ['QuickRun']
  \ }}

NeoBundle 'tpope/vim-surround'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundleLazy 'junegunn/vim-easy-align', {
  \ 'autoload': {
  \   'commands' : ['EasyAlign'],
  \   'mappings' : ['<Plug>(EasyAlign)'],
  \ }}

if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc.vim',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif
NeoBundleLazy 'Shougo/neosnippet', {
  \ 'depends' : 'Shougo/neosnippet-snippets',
  \ 'autoload' : {
  \   'insert' : 1,
  \   'filetypes' : 'snippet',
  \ }}
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'bling/vim-airline'

NeoBundle 'altercation/vim-colors-solarized'

NeoBundleLazy 'pangloss/vim-javascript', {
  \   'filetypes' : ['javascript'],
  \ }

NeoBundleLazy 'fatih/vim-go', {
  \   'filetypes' : ['go'],
  \ }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"---------------------------------------------------
" Basic
"----------------------------------------------------
" 改行コードの自動認識
set fileformats=unix,dos,mac
" ビープ音を鳴らさない
set vb t_vb=
" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start
" マウスモード有効
set mouse=a
" screen対応
set ttymouse=xterm2
" OSのクリップボードを使用する
" set clipboard+=unnamed
" インクリメント・デクリメントを10進数に
set nf=""

"---------------------------------------------------
" Apperance
"----------------------------------------------------
set number
set laststatus=2

syntax enable
set t_Co=256
set background=dark
let g:solarized_termtrans=1
colorscheme solarized

if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

"---------------------------------------------------
" Indent
"----------------------------------------------------
set tabstop=2 shiftwidth=2 softtabstop=0

"----------------------------------------------------
" Search
"----------------------------------------------------
" コマンド、検索パターンを100個まで履歴に残す
set history=100
" 検索の時に大文字小文字を区別しない
set ignorecase
" 検索の時に大文字が含まれている場合は区別して検索する
set smartcase
" 最後まで検索したら先頭に戻る
set wrapscan
" インクリメンタルサーチ
set incsearch
" 検索結果文字列のハイライトを有効にする
set hlsearch
"escでハイライトをオフ
nnoremap <silent> <ESC><ESC> :noh<CR>

"----------------------------------------------------
" Keybind
"----------------------------------------------------
" ESC
inoremap jk <Esc>

" Move
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>

" Edit
nnoremap <Space>o :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <Space>O :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" File
nnoremap <Space>w :<C-u>w<CR>
nnoremap <Space>q :<C-u>q<CR>
nnoremap <Space>Q :<C-u>q!<CR>

"----------------------------------------------------
" AutoCMD
"----------------------------------------------------
if has("autocmd")
  augroup saveLastPosition
    autocmd!
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END

  augroup sourceVimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
  augroup END
endif

"----------------------------------------------------
" Unite
"----------------------------------------------------
let g:unite_enable_start_insert=1
nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file_rec/async<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite file_mru<CR>

"----------------------------------------------------
" VimFiler
"----------------------------------------------------
let g:vimfiler_as_default_explorer = 1
nnoremap <silent><C-u><C-j> :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR>

"----------------------------------------------------
" yankround
"----------------------------------------------------
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
nnoremap <silent> <C-u><C-p> :<C-u>Unite yankround<CR>

"----------------------------------------------------
" neocomplete
"----------------------------------------------------
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"----------------------------------------------------
" airline
"----------------------------------------------------
let g:airline_powerline_fonts=1
let g:airline_theme='luna'
let g:airline_extensions = ['branch', 'tabline']
