filetype plugin indent on

set encoding=utf-8
set nocompatible 
set number
set mouse=a

syntax enable

if empty(glob('~/.vim/autoload/plug.vim')) "Если vim-plug не стоит
  silent !curl -fLo ~/.vim/autoload/plug.awadwasd\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Поиск плагинов
call plug#begin('~/.vim/bundle')
  Plug 'preservim/nerdtree'
  Plug 'Vimjas/vim-python-pep8-indent'
  Plug 'dense-analysis/ale'
  Plug 'davidhalter/jedi-vim'
  Plug 'ervandew/supertab'
  Plug 'sheerun/vim-polyglot'
call plug#end()

" setup colorscheme
let g:molokai_original = 1
colorscheme monokai_custom

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" disabling ale_completion and reverse supertab mapping
" let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 0
let g:SuperTabMappingBackward = '<tab>'
let g:SuperTabMappingForward = '<C-tab>'

" autocmd FileType python map <buffer> <C-r> :w<CR>:exec '!python3-intel64' shellescape(@%, 1)<CR>
" autocmd FileType python imap <buffer> <C-r> <esc>:w<CR>:exec '!python3-intel64' shellescape(@%, 1)<CR>

" Hotkeys
noremap q b
noremap Q B
" start of the next word
noremap f w
noremap F W

"moving in normal mode
noremap a <left>
noremap A <left>
noremap w <up>
noremap W <up>
noremap s <down>
noremap S <down>
noremap d <right>
noremap D <right>

if has('macunix')
  " moving in insert mode
  inoremap <C-a> <left>
  inoremap <C-w> <up>
  inoremap <C-s> <down>
  inoremap <C-d> <right>
  
  " running python ctrl+r
  autocmd Filetype python noremap <buffer> <C-r> :w<CR>:ter python3-intel64 "%"<CR>
  autocmd Filetype python inoremap <buffer> <C-r> <esc>:w<CR>:ter python3-intel64 "%"<CR>
endif
