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
set colorcolumn=120
highlight ColorColumn ctermfg=118 ctermbg=235

set number
set mouse=a
set t_Co=256

set nobackup
set noswapfile
syntax enable


" Plugins search
call plug#begin('~/.vim/bundle')
  Plug 'preservim/nerdtree'
  Plug 'dense-analysis/ale'
  Plug 'ervandew/supertab'
  Plug 'sheerun/vim-polyglot'
  " автоматические скобки
  Plug 'jiangmiao/auto-pairs'
  Plug 'puremourning/vimspector'
   " you complete me
  Plug 'ycm-core/YouCompleteMe'
call plug#end()


if has('macunix')
    let g:os = 'macos'
else
    let g:os = 'linux'
endif


autocmd BufNew,BufRead *.asm set ft=tasm
autocmd VimEnter * call RunVim()
autocmd BufEnter *.py call GetPython()
autocmd BufEnter *.py silent! YcmRestartServer

" Setup ui
if g:os == 'macos'
    set guifont=JetBrainsMono-Regular:h13
    set linespace=3
else
    set guifont=JetBrainsMono\ Regular\ 11
    set guioptions=rl " egmrLtT - default value,
                      " custom: right, left scroll always,
                      " because of gvim bug
endif

let g:molokai_original = 1
colorscheme monokai_custom
set signcolumn=yes

" JetBrainsMono doesn't support default vimspector signs
sign define vimspectorBP text=o             texthl=WarningMsg
sign define vimspectorBPCond text=o?        texthl=WarningMsg
sign define vimspectorBPLog text=!!         texthl=SpellRare
sign define vimspectorBPDisabled text=o!    texthl=LineNr
sign define vimspectorPC text=\ >           texthl=MatchParen
sign define vimspectorPCBP text=o>          texthl=MatchParen
sign define vimspectorCurrentThread text=>  texthl=MatchParen
sign define vimspectorCurrentFrame text=>   texthl=Special


" Ending setup ui


" ALE
" let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_linters = {
    \'python': ['pylint', 'mypy'],
    \'cpp': ['cc', 'clang'],
\}
let g:ale_fixers = {
    \'*': ['trim_whitespace'],
    \'python': ['autopep8', 'isort'],
\}
let g:ale_fix_on_save = 1
let g:ale_cpp_cc_options = "-std=c++2a -Wall"
let g:ale_cpp_clangd_options = "-std=c++2a -Wall"
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_set_signs = 1
let g:ale_virtualtext_cursor = 'current'
let g:ale_python_mypy_options = '--ignore-missing-imports --check-untyped-defs
      \ --disable-error-code attr-defined
      \ --disable-error-code import-untyped
      \ --disable-error-code union-attr'


" changing vimspector signs priority
let g:vimspector_sign_priority = {
    \    'vimspectorBP':          50,
    \    'vimspectorBPCond':      50,
    \    'vimspectorBPLog':       50,
    \    'vimspectorBPDisabled':  50,
    \    'vimspectorNonActivePC': 50,
    \    'vimspectorPC':          999,
    \    'vimspectorPCBP':        999,
    \ }


" if this is disabled, cpp ycm doesn't work on mac
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path'
  \]


"Hotkeys
let g:SuperTabMappingBackward = '<tab>'
let g:NERDTreeMapOpenVSplit = 'v'

noremap q ge
noremap Q ^
noremap E $

" start of the next word
noremap f w
noremap F W

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

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'
noremap ;t :call vimspector#ToggleBreakpoint()<CR>
noremap ;c :call vimspector#ClearBreakpoints()<CR>
noremap ;r :call vimspector#Launch()<CR>
" ycm
noremap gd :YcmCompleter GoTo<CR>
noremap <F2> :YcmCompleter RefactorRename
inoremap <F2> <Esc>:YcmCompleter RefactorRename

noremap nf :NERDTreeFocus<CR>
" autocmd FileType python map <buffer> <C-r> :w<CR>:exec '!python3-intel64' shellescape(@%, 1)<CR>
if g:os == 'macos'
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
  if has("gui_running")
    noremap <A-a> <left>
    noremap <A-w> <up>
    noremap <A-s> <down>
    noremap <A-d> <right>
    inoremap <A-a> <left>
    inoremap <A-w> <up>
    inoremap <A-s> <down>
    inoremap <A-d> <right>
    inoremap <A-c> <Esc>
  else
  " alt in console is escaped seq ^], so this is why <Esc>key works like <A-key>
  " sed -n l
    inoremap <Esc>a <left>
    inoremap <Esc>w <up>
    inoremap <Esc>s <down>
    inoremap <Esc>d <right>
    inoremap <Esc>c <Esc>
  endif

  let g:SuperTabMappingForward = '<A-tab>'
  noremap <A-t> :NERDTreeToggle<CR>
  inoremap <A-t> <Esc>:NERDTreeToggle<CR>i

  " normal cut and copy
  noremap <C-c> "+yi<Esc>
  noremap <C-x> "+c<Esc>
  noremap <C-v> i<C-r><C-o>+
  noremap <C-z> u
  noremap <C-s> :w<CR>
  noremap <C-a> ggVG
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


function RunVim()
  :NERDTree | wincmd p
  :call GetPython()
endfunction


function RunPython()
  if &readonly == 0
    :w
  endif
  execute $"ter {g:python} {escape(expand('%'), ' \')}"
  let b:ycm_largefile = 1
  NERDTreeRefreshRoot
endfunction


function GetPython()
  let is_global = 1
  let venv_dirs = ['venv', 'virtualenv', 'myenv', 'env']

  for dir in venv_dirs
    let check_dir = escape(finddir(dir . '/..', escape(expand('%:p:h').';', ' \')), ' \')
    if check_dir != ''
      let venv_dir = $"{check_dir}/{dir}"
      if isdirectory($"{venv_dir}/bin")
        let is_global = 0
        break
      endif
    endif
  endfor

  if is_global == 1
    if g:os == 'macos'
      let g:python = 'python3-intel64'
    else
      let g:python = 'python3'
    endif

  else
    let g:python = $"{venv_dir}/bin/python3"
  endif
  let g:ycm_python_interpreter_path = g:python

endfunction


function RunCpp()
  if &readonly == 0
    :w
  endif
  !g++ -std=c++2a *.cpp
  NERDTreeRefreshRoot
  ter ./a.out
  let b:ycm_largefile = 1 "disable ycm for terminal
endfunction


":cd %:p:h - change dir to current buffer
":ter python3-intel64 "%" "
