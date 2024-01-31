filetype plugin indent on
filetype off
syntax enable

set nobackup
set noswapfile
set nocompatible
set encoding=utf-8
set completeopt-=preview

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set smartindent
set autochdir
set mouse=a


if has('macunix')
  let g:os = 'macos'
  let g:ycm_python_interpreter_path = 'python3-intel64'
else
  let g:os = 'linux'
  let g:ycm_python_interpreter_path = 'python3'
  set shell=/bin/zsh
endif


" Plugins search
call plug#begin('~/.vim/bundle')
  " ui
  Plug 'preservim/nerdtree'
  Plug 'sheerun/vim-polyglot'
  Plug 'ryanoasis/vim-devicons'
  Plug 'lambdalisue/glyph-palette.vim'
  " bindings
  Plug 'ervandew/supertab'
  Plug 'jiangmiao/auto-pairs'
  Plug 'mg979/vim-visual-multi'
  " buffers
  Plug 'ap/vim-buftabline'
  " autocomplete, debug
  Plug 'dense-analysis/ale'
  Plug 'ycm-core/YouCompleteMe'
  Plug 'puremourning/vimspector'
call plug#end()


autocmd BufNew,BufRead *.asm set ft=tasm
autocmd VimEnter * NERDTree | wincmd p
autocmd BufRead,BufNew *.py call GetPython()
autocmd BufEnter *.py silent! call YcmRestartServerPython()


" Setup ui
if g:os == 'macos'
  set guifont=JetBrainsMono\ Nerd\ Font\ Regular:h13
  set linespace=3
  set fillchars+=vert:\│
else
  set guifont=JetBrainsMono\ Nerd\ Font\ Regular\ 11
  set guioptions=rl " egmrLtT - default value,
                    " custom: right, left scroll always,
                    " because of gvim bug
endif

let g:molokai_original = 1 " monokai background
let NERDTreeMinimalUI=1
let g:DevIconsDefaultFolderOpenSymbol=''
let g:DevIconsEnableFoldersOpenClose = 1
colorscheme codedark
set signcolumn=yes
set number
set colorcolumn=100
set nowrap
set display+=lastline " for long lines
set sidescroll=5
set listchars+=precedes:<,extends:>
set fillchars+=eob:\-
set fillchars+=vert:\│
set t_Co=256

highlight ColorColumn ctermfg=118 ctermbg=235

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
" Setup ui


" ALE
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
let g:ale_set_highlights = 0
let g:ale_virtualtext_cursor = 'current'
let g:ale_python_mypy_options = '--ignore-missing-imports --check-untyped-defs
      \ --disable-error-code attr-defined
      \ --disable-error-code import-untyped
      \ --disable-error-code union-attr
      \ --cache-dir=/dev/null'
let g:ale_python_auto_pipenv = 1

highlight clear ALEErrorSign
highlight clear ALEWarningSign
" ALE

" vimspector
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
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_filepath_blacklist = {}
let g:ycm_filetype_blacklist={
  \   'tagbar' : 1,
  \   'nerdtree' : 1,
  \   'markdown' : 1,
  \   'unite' : 1,
  \   'text' : 1,
  \   'csv' : 1,
  \}

let g:ycm_semantic_triggers =  {
  \   'scss,css': [ 're!^\s{2,4}', 're!:\s+' ],
  \   'objc' : ['->', '.'],
  \   'ocaml' : ['.', '#'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::', '(', 'use ', 'namespace ', '\'],
  \   'cs,java,typescript,d,perl6,scala,vb,elixir,go' : ['.', 're!(?=[a-zA-Z]{3,4})'],
  \   'html': ['<', '"', '</', ' '],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \   'haskell' : ['.', 're!.'],
  \ }


" Hotkeys
let g:SuperTabMappingBackward = '<tab>'
let g:NERDTreeMapOpenVSplit = 'v'
" moving in normal mode
noremap a <left>
noremap A <left>
noremap w <up>
noremap W <up>
noremap s <down>
noremap S <down>
noremap d <right>
noremap D <right>
" russian
noremap ф <left>
noremap Ф <left>
noremap ц <up>
noremap Ц <up>
noremap ы <down>
noremap ы <down>
noremap в <right>
noremap В <right>
" complex navigation
noremap q ge
noremap Q ^
noremap E g_
" start of the next word
noremap f w
noremap F W
" commands
noremap j a
noremap J A
" russian
noremap ш i
noremap Ш I
noremap о a
noremap О A

" vimspector
noremap ;t :call vimspector#ToggleBreakpoint()<CR>
noremap ;c :call vimspector#ClearBreakpoints()<CR>
noremap ;r :call vimspector#Launch()<CR>
" ycm
noremap gd :YcmCompleter GoTo<CR>
noremap <F2> :YcmCompleter RefactorRename<Space>
inoremap <F2> <Esc>:YcmCompleter RefactorRename<Space>

noremap nf :NERDTreeFocus<CR>
" autocmd FileType python map <buffer> <C-r> :w<CR>:exec '!python3-intel64' shellescape(@%, 1)<CR>
if g:os == 'macos'
  let g:SuperTabMappingForward = '<C-tab>'
  " moving in buffer
  noremap <C-a> <left>
  noremap <C-w> <up>
  noremap <C-s> <down>
  noremap <C-d> <right>
  inoremap <C-a> <left>
  inoremap <C-w> <up>
  inoremap <C-s> <down>
  inoremap <C-d> <right>
  " moving between buffers
  noremap <silent> <C-k> :wincmd k<CR>
  noremap <silent> <C-h> :wincmd h<CR>
  noremap <silent> <C-j> :wincmd j<CR>
  noremap <silent> <C-l> :wincmd l<CR>
  noremap <silent> <D-h> :call SwitchBuffer('bprev')<CR>
  noremap <silent> <D-l> :call SwitchBuffer('bnext')<CR>
  noremap <D-w> :bd<CR>
  inoremap <D-w> <Esc>:bd<CR>
  " NerdTree
  noremap <C-e> :NERDTreeToggle<CR>
  inoremap <C-e> <Esc>:NERDTreeToggle<CR>i
  " python
  autocmd Filetype python noremap <buffer> <C-r> :call RunPython()<CR>
  autocmd Filetype python inoremap <buffer> <C-r> <Esc>:call RunPython()<CR>
  " cpp
  autocmd Filetype cpp noremap <buffer> <C-r> :call RunCpp()<CR>
  autocmd FileType cpp inoremap <buffer> <C-r> <Esc>:call RunCpp()<CR>
  " js
  autocmd Filetype javascript noremap <buffer> <C-r> :call RunJS()<CR>
  autocmd Filetype javascript inoremap <buffer> <C-r> <Esc>:call RunJS()<CR>

else
  if has("gui_running")
    let g:SuperTabMappingForward = '<A-tab>'
    noremap <A-ScrollWheelUp> 3zh
    noremap <A-ScrollWheelDown> 3zl

    noremap <A-a> <left>
    noremap <A-w> <up>
    noremap <A-s> <down>
    noremap <A-d> <right>
    inoremap <A-a> <left>
    inoremap <A-w> <up>
    inoremap <A-s> <down>
    inoremap <A-d> <right>
    inoremap <A-c> <Esc>
    " moving between buffers
    noremap <silent> <A-k> :wincmd k<CR>
    noremap <silent> <A-h> :wincmd h<CR>
    noremap <silent> <A-j> :wincmd j<CR>
    noremap <silent> <A-l> :wincmd l<CR>
    " NerdTree
    noremap <A-e> :NERDTreeToggle<CR>
    inoremap <A-e> <Esc>:NERDTreeToggle<CR>i
    " python
    autocmd FileType python noremap <buffer> <A-r> :call RunPython()<CR>
    autocmd FileType python inoremap <buffer> <A-r> <Esc>:call RunPython()<CR>
    " cpp
    autocmd Filetype cpp noremap <buffer> <A-r> :call RunCpp()<CR>
    autocmd FileType cpp inoremap <buffer> <A-r> <Esc>:call RunCpp()<CR>
    " js
    autocmd Filetype javascript noremap <buffer> <A-r> :call RunJS()<CR>
    autocmd Filetype javascript inoremap <buffer> <A-r> <Esc>:call RunJS()<CR>

  else
    let g:SuperTabMappingForward = '<Esc><Tab>'
    " alt in console is escaped seq ^], so this is why <Esc>key works like <A-key>
    " sed -n l
    inoremap <Esc>a <left>
    inoremap <Esc>w <up>
    inoremap <Esc>s <down>
    inoremap <Esc>d <right>
    inoremap <Esc>c <Esc>
    " moving between buffers
    noremap <silent> <Esc>k :wincmd k<CR>
    noremap <silent> <Esc>h :wincmd h<CR>
    noremap <silent> <Esc>j :wincmd j<CR>
    noremap <silent> <Esc>l :wincmd l<CR>
    " NerdTree
    noremap <Esc>e :NERDTreeToggle<CR>
    inoremap <Esc>e <Esc>:NERDTreeToggle<CR>i
    " python
    autocmd Filetype python noremap <buffer> <Esc>r :call RunPython()<CR>
    autocmd filetype python inoremap <buffer> <Esc>r <Esc>:call RunPython()<CR>
    " cpp
    autocmd Filetype cpp noremap <buffer> <Esc>r :call RunCpp()<CR>
    autocmd FileType cpp inoremap <buffer> <Esc>r <Esc>:call RunCpp()<CR>
    " js
    autocmd Filetype javascript noremap <buffer> <Esc>r :call RunJS()<CR>
    autocmd Filetype javascript inoremap <buffer> <Esc>r <Esc>:call RunJS()<CR>
  endif

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
  tnoremap <C-c> <C-W>N
  tnoremap <C-v> <C-W>"+
  " buffers
  noremap <silent> <C-h> :call SwitchBuffer('bprev')<CR>
  noremap <silent> <C-l> :call SwitchBuffer('bnext')<CR>
  noremap <silent> <C-w> :bd<CR>
  inoremap <silent> <C-w> <Esc>:bd<CR>
endif


function SwitchBuffer(act)
  if &filetype == 'nerdtree'
    wincmd l
    execute a:act
  else
    execute a:act
  endif
endfunction


function GetPython()
  let is_global = 1
  let venv_dirs = ['venv', 'virtualenv']

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
      let b:python = 'python3-intel64'
    else
      let b:python = 'python3'
    endif

  else
    let b:python = $"{venv_dir}/bin/python3"
  endif
endfunction


function RunPython()
  wall
  execute $"ter {b:python} {escape(expand('%'), ' \')}"
  NERDTreeRefreshRoot
endfunction


function YcmRestartServerPython()
  let g:ycm_python_interpreter_path = b:python
  YcmRestartServer
endfunction


function RunCpp()
  let recompile = 0
  if filereadable("test") == 0
    let recompile = 1

  else
    for buf in getbufinfo({'bufmodified': 1})
      if buf.changed
        let recompile = 1
        break
      endif
    endfor
  endif

  if recompile == 1
    wall
    !g++ -o test -g -std=c++2a *.cpp
  endif

  NERDTreeRefreshRoot
  ter ./test
endfunction


function RunJS()
  wall
  execute $"ter node {escape(expand('%'), ' \')}"
  NERDTreeRefreshRoot
endfunction

