filetype plugin indent on
filetype off

syntax enable

set autochdir
" set clipboard^=unnamed,unnamedplus после этого x будет копировать в
" системный буффер, что мне не очень нужно
set colorcolumn=100
set completeopt-=preview
set display+=lastline " for long lines
set encoding=utf-8
set expandtab
set fillchars+=eob:\-
set fillchars+=vert:\│
set history=1000
set listchars+=precedes:<,extends:>
set mouse=a
set nobackup
set nocompatible  " отключаем совместимость с vi
set nohlsearch " отключаем подсветку после поиска
set noswapfile
set nowrap
set number
set shiftwidth=4
set sidescroll=5
set signcolumn=yes
set smartindent
set smarttab
set softtabstop=4
set t_Co=256
set tabstop=4
set undolevels=1000 " изменяем размер истории последних изменений
set whichwrap+=<,>,h,l,[,] " перемещение на следующую строку после достижения конца
set wildchar=<Tab>
set wildmenu " автодополнение в командном режиме



if has('macunix')
  set guifont=JetBrainsMono\ Nerd\ Font\ Regular:h13
  set linespace=3
  set fillchars+=vert:\│
  let g:os = 'macos'
  let g:ycm_python_interpreter_path = 'python3-intel64'
else
  set shell=/bin/zsh
  set guifont=JetBrainsMono\ Nerd\ Font\ Mono\ Regular\ 11
  set guioptions=rl " egmrLtT - default value,
                    " custom: right, left scroll always,
                    " because of gvim bug
  let g:os = 'linux'
  let g:ycm_python_interpreter_path = 'python3'
endif
let g:home = $HOME

" Plugins search
call plug#begin('~/.vim/bundle')
  " autocomplete, debug
  Plug 'dense-analysis/ale'
  Plug 'ycm-core/YouCompleteMe'
  Plug 'puremourning/vimspector'
  " ui
  Plug 'preservim/nerdtree'
  Plug 'sheerun/vim-polyglot'
  Plug 'ryanoasis/vim-devicons'
  Plug 'lambdalisue/glyph-palette.vim'
  Plug 'sainnhe/gruvbox-material'
  " bindings
  Plug 'ervandew/supertab'
  Plug 'jiangmiao/auto-pairs'
  Plug 'mg979/vim-visual-multi'
  " buffers
  Plug 'zefei/vim-wintabs'
  Plug 'zefei/vim-wintabs-powerline'
call plug#end()


autocmd BufNew,BufRead *.asm set ft=tasm
autocmd VimEnter * call RunVim()
autocmd BufRead,BufNew *.py call GetPython()
autocmd BufEnter *.py silent! call YcmRestartServerPython()

let NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer = 1
let g:DevIconsDefaultFolderOpenSymbol=''
let g:DevIconsEnableFoldersOpenClose = 1
let g:molokai_original = 1 " monokai background
colorscheme codedark
" set background=dark " for gruvbox
" let g:gruvbox_material_background = 'medium'
" colorscheme gruvbox-material


highlight ColorColumn ctermfg=118 ctermbg=235

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" wintabs
let g:wintabs_autoclose=2
" ALE
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_linters = {
    \'python': ['pylint', 'mypy'],
    \'cpp': ['cc', 'clang'],
\}
let g:ale_fixers = {
    \'*': ['trim_whitespace'],
    \'python': ['black', 'isort'],
    \'cpp': ['clang-format']
\}
let g:ale_fix_on_save = 1
let g:ale_cpp_cc_options = "-std=c++2a -Wall"
let g:ale_cpp_clangd_options = "-std=c++2a -Wall"
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_set_signs = 1
let g:ale_set_highlights = 0
let g:ale_virtualtext_cursor = 'current'
let g:ale_python_black_options = '--line-length 120'
let g:ale_python_mypy_options = '--ignore-missing-imports --check-untyped-defs
      \ --disable-error-code attr-defined
      \ --disable-error-code import-untyped
      \ --disable-error-code union-attr
      \ --cache-dir=/dev/null'
let g:ale_python_isort_options = '--profile black'
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
noremap q ge
noremap Q ^
noremap E g_
" start of the next word
noremap f w
noremap F W
" commands
noremap j a
noremap J A
" передвижение в нормальном режиме русские клавиши, почти везде map, чтобы
" можно было использовать кириллицу в nerdtree, не nmap, т.к. иначе не будет
" ничего работать в визуальном режиме
map ф a
map Ф A
map ц w
map Ц W
map ы s
map Ы S
map в d
map В D
map у e
map пп gg
map П G
map Х {
map Ъ }
map Ж :
map щ o
map й ge
map Й ^
map У g_
" здесь без map, т.к. иначе русская а будет стрелкой вверх
noremap а w
noremap А W
" commands
map ч x
map Ч X
map м v
map М V
map ш i
map Ш I
noremap о a
noremap О A
" vimspector
noremap ;t :call vimspector#ToggleBreakpoint()<CR>
noremap ;c :call vimspector#ClearBreakpoints()<CR>
noremap ;r :wa<CR>:call vimspector#Launch()<CR>
noremap же :call vimspector#ToggleBreakpoint()<CR>
noremap жс :call vimspector#ClearBreakpoints()<CR>
noremap жк :wa<CR>:call vimspector#Launch()<CR>
" ycm
noremap gd :YcmCompleter GoTo<CR>
noremap <F2> :YcmCompleter RefactorRename<Space>
inoremap <F2> <Esc>:YcmCompleter RefactorRename<Space>

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
  noremap <silent> <D-h> :WintabsPrevious<CR>
  noremap <silent> <D-l> :WintabsNext<CR>
  noremap <silent> <D-w> :WintabsClose<CR>
  inoremap <silent> <D-w> <Esc>:WintabsClose<CR>
  " terminal
  tnoremap <silent> <C-t> <C-\><C-n>:resize 1<CR>:wincmd j<CR>
  noremap <silent> <C-t> :call OpenOrToggleTerminal()<CR><C-\><C-n>i
  " NerdTree
  noremap <silent> <C-e> :NERDTreeToggle<CR>
  inoremap <silent> <C-e> <Esc>:NERDTreeToggle<CR>i
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
    vnoremap <A-c> <Esc>
    " Russian
    noremap <A-ф> <left>
    noremap <A-ц> <up>
    noremap <A-ы> <down>
    noremap <A-в> <right>
    inoremap <A-ф> <left>
    inoremap <A-ц> <up>
    inoremap <A-ы> <down>
    inoremap <A-в> <right>
    inoremap <A-с> <Esc>
    vnoremap <A-с> <Esc>
    " moving between buffers
    noremap <silent> <A-k> :wincmd k<CR>
    noremap <silent> <A-h> :wincmd h<CR>
    noremap <silent> <A-j> :wincmd j<CR>
    noremap <silent> <A-l> :wincmd l<CR>
    " Russian
    noremap <silent> <A-л> :wincmd k<CR>
    noremap <silent> <A-р> :wincmd h<CR>
    noremap <silent> <A-о> :wincmd j<CR>
    noremap <silent> <A-д> :wincmd l<CR>
    " NerdTree
    noremap <silent> <A-e> :NERDTreeToggle<CR>
    inoremap <silent> <A-e> <Esc>:NERDTreeToggle<CR>i
    " Russian
    noremap <silent> <A-у> :NERDTreeToggle<CR>
    inoremap <silent> <A-у> <Esc>:NERDTreeToggle<CR>i
    " python
    autocmd FileType python noremap <buffer> <A-r> :call RunPython()<CR>
    autocmd FileType python inoremap <buffer> <A-r> <Esc>:call RunPython()<CR>
    " Russian
    autocmd FileType python noremap <buffer> <A-к> :call RunPython()<CR>
    autocmd FileType python inoremap <buffer> <A-к> <Esc>:call RunPython()<CR>
    " cpp
    autocmd Filetype cpp noremap <buffer> <A-r> :call RunCpp()<CR>
    autocmd FileType cpp inoremap <buffer> <A-r> <Esc>:call RunCpp()<CR>
    " Russian
    autocmd Filetype cpp noremap <buffer> <A-к> :call RunCpp()<CR>
    autocmd FileType cpp inoremap <buffer> <A-к> <Esc>:call RunCpp()<CR>
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
    noremap <silent> <Esc>e :NERDTreeToggle<CR>
    inoremap <silent> <Esc>e <Esc>:NERDTreeToggle<CR>i
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
  " terminal
  tnoremap <C-c> <C-W>N
  tnoremap <C-v> <C-W>"+
  tnoremap <silent> <A-t> <C-\><C-n>:resize 1<CR>:wincmd j<CR>
  noremap <silent> <A-t> :call OpenOrToggleTerminal()<CR><C-\><C-n>i
  " buffers
  noremap <silent> <C-h> :WintabsPrevious<CR>
  noremap <silent> <C-l> :WintabsNext<CR>
  noremap <silent> <C-w> :WintabsClose<CR>
  inoremap <silent> <C-w> <Esc>:WintabsClose<CR>
  " Russian
  noremap <silent> <C-р> :WintabsPrevious<CR>
  noremap <silent> <C-д> :WintabsNext<CR>
  noremap <silent> <C-ц> :WintabsClose<CR>
  inoremap <silent> <C-ц> <Esc>:WintabsClose<CR>
endif


function RunVim()
  NERDTree | wincmd p
  if g:os == 'linux'
    call GetPython()
    let g:ycm_python_interpreter_path = b:python
  endif
endfunction


function GetPython()
  let is_global = 1
  let venv_dirs = ['.venv', 'venv', 'virtualenv']
  for dir in venv_dirs
    let check_dir = finddir(dir . '/..', expand('%:p:h'))
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
    let b:python = escape($"{venv_dir}/bin/python3", ' \')
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


function CppCheckRecompile()
  let recompile = 0
  if filereadable("test") == 0
    return 1
  endif

  for buf in getbufinfo({'bufmodified': 1})
    if buf.changed
      return 1
    endif
  endfor

  for file in split(globpath('.', '*.cpp'), '\n') + split(globpath('.', '*.h'), '\n')
    if strftime('%y%m%d %T', getftime('test')) < strftime('%y%m%d %T', getftime(file))
      return 1
    endif
  endfor

  return 0
endfunction


function RunCpp()
  let recompile = CppCheckRecompile()
  if recompile == 1
    wall
    execute $"ter bash {g:home}/.vim/bundle/scripts/cpp.sh"
  else
    ter ./test
  endif

  NERDTreeRefreshRoot
endfunction


function OpenOrToggleTerminal()
    " Проверяем, есть ли уже открытый терминал
    if winnr('$') > 1 && bufwinnr('!/bin/zsh') != -1
      " Если терминал открыт, переключаемся на него
      let term_win = bufwinnr('!/bin/zsh')
      execute term_win . 'wincmd w'
    else
      if &filetype == 'nerdtree'
        wincmd l
      endif
      " Если терминал не открыт, открываем его
      ter
    endif
    resize 15
endfunction

