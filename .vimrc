" .vimrc file

" Basic setings ---------------------- {{{

" Set encoding
set encoding=utf-8

" Set update time
set updatetime=100

" Set case sensitivity
set ignorecase smartcase

"Set search behavior
set hlsearch
set incsearch

" Set up tabs
set expandtab tabstop=2 shiftwidth=2

" Share Windows clipboard
set clipboard=unnamed

" }}}

" Display settings ---------------------- {{{

syntax on " Turn on syntax highlightling (usually on by default, but just in case)
" Set line numbers
  set number
  set relativenumber
set cursorline " Highlight line cursor is on
set scrolloff=10 " scroll display when within 10 lines of the edge of the screen
" Indicate 80 character width
  set textwidth=80
  set colorcolumn=+1
set foldlevelstart=0 " Set starting fold level (hide folds by default)
" Set split opening defaults
  set splitbelow
  set splitright
" Set font based on platform
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    "set guifont=Consolas:h12:cANSI
    set guifont=SpaceMono_NF:h10:cANSI:qDRAFT
  endif
endif

" Set up windows for full-screen
if has("gui_running")
  if has("gui_win32")
    " Disable toolbars (to allow for fullscreen view)
      set guioptions-=m "menu bar
      set guioptions-=T "toolbar
      set guioptions-=r "scroll bar
      set guioptions-=L "left-hand scroll bar
    "Map F11 key for full screen toggle (requires gvim fullscreen DLL)
      noremap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
  endif
endif

" }}}

" Filetype settings ---------------------- {{{

  " HTML specific settings ---------------------- {{{
  augroup filetype_html
    autocmd!
    autocmd BufNewFile,BufRead *.html setlocal nowrap
  augroup END
  " }}}

  " Vimscript file settings ---------------------- {{{
  augroup filetype_vim
      autocmd!
      autocmd FileType vim setlocal foldmethod=marker
  augroup END
  " }}}

" }}}

" Training mappings ---------------------- {{{

  " Disable escape key in inert mode, in favor of jk ---------------------- {{{
  " can't use escape to get out of insert mode
    inoremap <esc> <nop>
  " use jk instead
    inoremap jk <esc>
  " }}}

  " Disable arrow keys ---------------------- {{{
  " in normal mode
  noremap <Up> <NOP>
  noremap <Down> <NOP>
  noremap <Left> <NOP>
  noremap <Right> <NOP>
  " in insert mode
  inoremap <Up>    <NOP>
  inoremap <Down>  <NOP>
  inoremap <Left>  <NOP>
  inoremap <Right> <NOP>
  " }}}

" }}}

" Mappings ---------------------- {{{

  " Set leader and local leader ---------------------- {{{
    let mapleader = ","
    let maplocalleader = " "
  " }}}

  " vimrc-related ---------------------- {{{
    " open _vimrc file for editing
      "nnoremap <leader>rc :edit $HOME\_vimrc<CR>
      nnoremap <leader>rc :vsplit $HOME\_vimrc<CR>
    " re-source _vimrc file
      nnoremap <leader>so :source $HOME\_vimrc<CR>
  " }}}

  "  Navigation between vim panes ---------------------- {{{
    nnoremap <silent> <C-h> :wincmd h<CR>
    nnoremap <silent> <C-j> :wincmd j<CR>
    nnoremap <silent> <C-k> :wincmd k<CR>
    nnoremap <silent> <C-l> :wincmd l<CR>
  " }}}

  " add line without leaving normal mode
    nnoremap <leader>al O<esc>0d$
  " minus to move a line down
    nnoremap - ddp
  " underscore to move a line up
    nnoremap _ ddkkp
  " This unsets the "last search pattern" register by hitting return
    nnoremap <CR> :noh<CR><CR>
  " shortcut to uppercase a word
    nnoremap <C-u> <C-v> iwU
  " put a word in double-quotes
    nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
  " put a word in single-quotes
    nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
  " Comment-out lines ---------------------- {{{
  augroup comment_remaps
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType html nnoremap <buffer> <localleader>c I<!--<esc>A--><esc>
    autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
  augroup END
  " }}}

" }}}

" Abbreviations ---------------------- {{{

  " Misspellings
  iabbrev adn and

" }}}

" Python settings ---------------------- {{{
  " Set python3 path to specify version 3.6
  set pythonthreehome=C:\python36-32\
  set pythonthreedll=C:\python36-32\python36.dll
" }}}

" Plugins ---------------------- {{{
call plug#begin('~/vimfiles/plugged')
Plug 'chriskempson/base16-vim'
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
call plug#end()
" }}}

" Set colorscheme (depends on plugin)
colorscheme base16-3024

" NERDTree settings ---------------------- {{{

  " autocommands
    augroup nerdtree
      " On open, start NERDTree and put the cursor back in the other window.
        autocmd VimEnter * NERDTree | wincmd p
      " Exit Vim if NERDTree is the only window left.
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
          \ quit | endif
    augroup END
  " settings
    " show hidden files
    let NERDTreeShowHidden=1
    " ignore certain file types
    let NERDTreeIgnore = ['\.DAT$']
    "let g:NERDTreeFileExtensionHighlightFullName = 1
  " mappings
    " control-t or leader-nt to toggle NERDTree
    nnoremap <leader>nt :NERDTreeToggle<CR>
    " NERDTreeFind shortcut
    nnoremap <leader>nf :NERDTreeFind<CR>

" }}}
