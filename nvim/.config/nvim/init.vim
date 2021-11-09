" ----------------------------------------------------------------------------
" Automatic vim-plug install if needed
" ----------------------------------------------------------------------------
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !/usr/bin/curl --silent -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC | qa
endif

" ----------------------------------------------------------------------------
" Plugins list #start
" ----------------------------------------------------------------------------
" polyglot config
let g:polyglot_disabled = ['csv']

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/vim-plug'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'luochen1990/rainbow'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'samoshkin/vim-mergetool'
Plug 'tpope/vim-fugitive'
Plug 'rhlobo/vim-super-retab'
Plug 'preservim/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-eunuch'

call plug#end()
" ----------------------------------------------------------------------------
" Plugins list #end
" ----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" Main editor settings #start
" -----------------------------------------------------------------------------
set nocompatible                  " be iMproved, required
filetype off                      " required
set encoding=utf-8                " UTF-8 encoding for plugins
set cursorline                    " Highlight current line
set number                        " Show line numbers
set relativenumber                " Show relative line numbers
set shiftwidth=4                  " Indent by 4 spaces when using >>, <<, == etc.
set softtabstop=4                 " Indent by 4 spaces when pressing <TAB>
set tabstop=4                     " How many columns a tab counts for
set expandtab                     " Use softtabstop spaces instead of tab characters for indentation
set smarttab	                  " Enable smart-tabs
set showmatch	                  " Highlight matching brace
set ruler                         " Show row and column ruler information
set autoindent                    " Keep indentation from previous line
set backspace=2                   " Make backspace work like most other apps
"set textwidth=100                 " Make lines max 100 chars
set hlsearch                      " Highlight searched phrase
set incsearch                     " Search while typing
set ignorecase                    " Case insensitive search
set smartcase                     " Case sensitive when search phrase is case sensitive otherwise not
set noswapfile                    " Don't create swapfiles (*.swp)
set splitbelow                    " Open splits below current one
set splitright                    " Open splits right from the current one
set backspace=indent,eol,start    " Backspace behaviour
let mapleader=","                 " Leader key

" Resize split windows with mouse
if has('mouse')
    set mouse=a
endif

" Color settings
set t_Co=256
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
if &term =~ '256color'
    set t_ut=
    set t_TI=
    set t_TE=
endif

" Set colorshcheme
set background=dark
if (match(system("find ${HOME}/.config/nvim/ -maxdepth 2 -type d | grep -c 'gruvbox'"), "1") != -1)
    colorscheme gruvbox
endif

" Syntax highlight
filetype plugin indent on
syntax on

" Use 4 spaces indentation
au FileType python,perl
    \ setlocal tabstop=4 softtabstop=4 shiftwidth=4

" Use 2 spaces indentation
au FileType xml,javascript,html,css
    \ setlocal tabstop=2 softtabstop=2  shiftwidth=2

" History settings
set history=700
set undolevels=700

" Enable code folding
set foldmethod=indent
set foldlevel=99

" Git stuff
autocmd Filetype gitcommit setlocal spell textwidth=70
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell textwidth=70 syntax=gitcommit

" Run black on python scripts on save
" autocmd BufWrite *.py :! black --target-version py36 --line-length 100 %:p

" Vim viewport config (switching between split windows)
nmap <silent> <S-Up> :wincmd k<CR>
nmap <silent> <S-Down> :wincmd j<CR>
nmap <silent> <S-Left> :wincmd h<CR>
nmap <silent> <S-Right> :wincmd l<CR>

" Vim filetabs config
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Clipboard settings
vmap <C-c> :w !xclip -selection clipboard<CR><CR>

" -----------------------------------------------------------------------------
" Main editor settings #end
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" Plugins config #start
" -----------------------------------------------------------------------------

" lightline config
let g:lightline = {
        \ 'colorscheme': 'seoul256',
      \ }
set laststatus=2

" vim-rainbow config
let g:rainbow_active = 1
map <C-p> :RainbowToggle<CR>

" nerdtree config
map <silent> <C-n> :ToggleNERDTree<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeHighlightCursorline = 0

" tagbar config
nnoremap <silent> <S-t> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_indent = 2
let g:tagbar_sort = 0

" vim-better-whitespace config
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" vim-mergetool config
let g:mergetool_layout = 'mr'
"let g:mergetool_prefer_revision = 'local'
"let g:mergetool_prefer_revision = 'remote'

" fzf config
let g:fzf_preview_window = ''
let g:fzf_command_prefix = 'Fzf'
map <silent> <C-f> :FzfFiles<CR>

" -----------------------------------------------------------------------------
" Plugins config #end
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" Custom functions #start
" -----------------------------------------------------------------------------

function! OpenNerdTreeWithRainbowDisabled()
  RainbowToggle
  NERDTreeToggle
  RainbowToggle
endfunction
command! ToggleNERDTree call OpenNerdTreeWithRainbowDisabled()

function! DoFormatXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<FormatXML>'
  $put ='</FormatXML>'
  silent %!xmllint --format --recover -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  1d
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! FormatXML call DoFormatXML()

" -----------------------------------------------------------------------------
" Custom functions #end
" -----------------------------------------------------------------------------
