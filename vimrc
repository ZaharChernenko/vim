filetype plugin indent on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set encoding=utf-8
set nocompatible 
set number
set mouse=a
set t_Co=256

syntax enable

if empty(glob('~/.vim/autoload/plug.vim')) "Если vim-plug не стоит
  silent !curl -fLo ~/.vim/autoload/plug\
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Поиск плагинов
call plug#begin('~/.vim/bundle')
  Plug 'preservim/nerdtree'
  Plug 'Vimjas/vim-python-pep8-indent'
  Plug 'dense-analysis/ale'
  " Plug 'davidhalter/jedi-vim'
  Plug 'ervandew/supertab'
  Plug 'sheerun/vim-polyglot'
  " you complete me
  Plug 'VundleVim/Vundle.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'git://git.wincent.com/command-t.git'
  Plug 'file:///home/gmarik/path/to/plugin'
  Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
  Plug 'ycm-core/YouCompleteMe'
call plug#end()

" setup colorscheme
let g:molokai_original = 1
colorscheme monokai_custom
highlight Normal ctermbg=NONE
highlight notText ctermbg=NONE
if has('macunix')
  set guifont=Monaco:h12
else
  set guifont=Monaco\ Regular\ 10
endif
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" disabling ale_completion and reverse supertab mapping
" let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_linters = {'cpp': ['cc', 'clang', 'cppcheck']}
let g:ale_cpp_cc_options = "-std=c++17 -Wall"
let g:ale_cpp_clangd_options = "-std=c++17 -Wall"

" let g:ycm_server_python_interpreter='/usr/local/bin/python3'
let g:ycm_global_ycm_extra_conf = '/Users/zahar/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

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
  autocmd Filetype python noremap <buffer> <C-r> :w<CR> :cd %:p:h<CR> :ter python3-intel64 "%"<CR>
  autocmd Filetype python inoremap <buffer> <C-r> <esc>:w<CR> :cd %:p:h<CR> :ter python3-intel64 "%"<CR>
  " running c++ ctrl+r
  autocmd Filetype cpp noremap <buffer> <C-r> :w<CR> :cd %:p:h<CR> :!g++ -std=c++20 *.cpp<CR> :NERDTreeRefreshRoot<CR> :ter ./a.out<CR>
  autocmd FileType cpp inoremap <buffer> <C-r> <Esc>:w<CR> :cd %:p:h<CR> :!g++ -std=c++20 *.cpp<CR> :NERDTreeRefreshRoot<CR> :ter ./a.out<CR>
else
  " for gui
  autocmd FileType python noremap <buffer> <A-r> :w<CR> :cd %:p:h<CR> :ter python "%"<CR>
  autocmd FileType python inoremap <buffer> <A-r> <Esc>:w<CR> :cd %:p:h<CR> :ter python "%"<CR>
  " running c++ alt+r
  autocmd Filetype cpp noremap <buffer> <A-r> :w<CR> :cd %:p:h<CR> :!g++ -std=c++20 *.cpp<CR> :NERDTreeRefreshRoot<CR> :ter ./a.out<CR>
  autocmd Filetype cpp inoremap <buffer> <A-r> <Esc>:w<CR> :cd %:p:h<CR> :!g++ -std=c++20 *.cpp<CR> :NERDTreeRefreshRoot<CR> :ter ./a.out<CR>
  
  " removing buffer
  noremap <C-w> :bd<CR>
  inoremap <C-w> <Esc>:bd<CR>
  " movement in Gvim
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
endif
