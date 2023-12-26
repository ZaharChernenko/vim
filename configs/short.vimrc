filetype plugin indent on
filetype off

set completeopt-=preview
set encoding=utf-8
set nocompatible

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smarttab
set smartindent
set autochdir

set number
set mouse=a
set t_Co=256

set nobackup
set noswapfile
syntax enable
autocmd BufNew,BufRead *.asm set ft=tasm


" Plugins search
call plug#begin('~/.vim/bundle')
  Plug 'preservim/nerdtree'
  Plug 'ervandew/supertab'
  Plug 'sheerun/vim-polyglot'
  " автоматические скобки
  Plug 'jiangmiao/auto-pairs'
call plug#end()


" Setup ui
let g:molokai_original = 1
colorscheme monokai_custom
set signcolumn=yes


" Hotkeys
noremap q ge
noremap Q B
" start of the next word
noremap f w
noremap F W

let g:SuperTabMappingBackward = '<tab>'

" moving in normal mode
noremap ф <left>
noremap Ф <left>
noremap ц <up>
noremap Ц <up>
noremap ы <down>
noremap ы <down>
noremap в <right>
noremap В <right>

noremap a <left>
noremap A <left>
noremap w <up>
noremap W <up>
noremap s <down>
noremap S <down>
noremap d <right>
noremap D <right>

noremap j a
noremap J A

noremap ш i
noremap Ш I
noremap о a
noremap О A


" autocmd FileType python map <buffer> <C-r> :w<CR>:exec '!python3-intel64' shellescape(@%, 1)<CR>
if has('macunix')
  " moving in insert mode
  noremap <C-a> <left>
  noremap <C-w> <up>
  noremap <C-s> <down>
  noremap <C-d> <right>
  inoremap <C-a> <left>
  inoremap <C-w> <up>
  inoremap <C-s> <down>
  inoremap <C-d> <right>
  let g:SuperTabMappingForward = '<C-tab>'
  noremap <C-t> :NERDTreeToggle<CR>
  inoremap <C-t> <Esc>:NERDTreeToggle<CR>i
  " running python ctrl+r
  autocmd Filetype python noremap <buffer> <C-r> :call RunPython()<CR>
  autocmd Filetype python inoremap <buffer> <C-r> <Esc>:call RunPython()<CR>
  " running c++ ctrl+r
  autocmd Filetype cpp noremap <buffer> <C-r> :call RunCpp()<CR>
  autocmd FileType cpp inoremap <buffer> <C-r> <Esc>:call RunCpp()<CR>

else
  " movement in Gvim
  noremap <A-a> <left>
  noremap <A-w> <up>
  noremap <A-s> <down>
  noremap <A-d> <right>
  inoremap <A-a> <left>
  inoremap <A-w> <up>
  inoremap <A-s> <down>
  inoremap <A-d> <right>
  inoremap <A-c> <Esc>
  " console insert mode movement
  " alt in console is escaped seq ^], so this is why <Esc>key works like <A-key>
  " sed -n l
  inoremap <Esc>a <left>
  inoremap <Esc>w <up>
  inoremap <Esc>s <down>
  inoremap <Esc>d <right>
  inoremap <Esc>c <Esc>

  let g:SuperTabMappingForward = '<A-tab>'
  noremap <A-t> :NERDTreeToggle<CR>
  inoremap <A-t> <Esc>:NERDTreeToggle<CR>i

  " normal cut and copy
  noremap <C-c> "+yi<Esc>
  noremap <C-x> "+c<Esc>
  noremap <C-v> i<C-r><C-o>+
  noremap <C-z> u
  noremap <C-s> :w<CR>
  inoremap <C-v> <C-r><C-o>+
  inoremap <C-s> <Esc>:w<CR>
  inoremap <C-z> <Esc>ui

  " running cpp and python on alt+r
  " running python
  " terminal
  autocmd Filetype python noremap <buffer> <Esc>r :call RunPython()<CR>
  autocmd filetype python inoremap <buffer> <Esc>r <Esc>:call RunPython()<CR>
  " gvim
  autocmd FileType python noremap <buffer> <A-r> :call RunPython()<CR>
  autocmd FileType python inoremap <buffer> <A-r> <Esc>:call RunPython()<CR>

  " running c++
  " terminal
  autocmd Filetype cpp noremap <buffer> <Esc>r :call RunCpp()<CR>
  autocmd Filetype cpp inoremap <buffer> <Esc>r <Esc>:call RunCpp()<CR>
  " gvim
  autocmd Filetype cpp noremap <buffer> <A-r> :call RunCpp()<CR>
  autocmd Filetype cpp inoremap <buffer> <A-r> <Esc>:call RunCpp()<CR>

  " removing buffer
  noremap <C-w> :bd<CR>
  inoremap <C-w> <Esc>:bd<CR>
endif



function RunPython()
  :w
  :cd %:p:h
  if has("macunix")
    :ter python3-intel64 "%"
  else
    :ter python3 "%"
  endif
endfunction



function RunCpp()
  :w
  :cd %:p:h
  :!g++ -std=c++2a *.cpp
  :NERDTreeRefreshRoot
  :ter ./a.out
endfunction

