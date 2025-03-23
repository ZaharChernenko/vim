filetype plugin indent on
filetype off

syntax enable

set autochdir
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
  " в macos старый python3.9, который не поддерживает match и generics
  " при установке на новый macos надо будет обязательно установить через pip
  " python3.12 -m pip install mypy
  let g:ale_python_mypy_executable = '/Library/Frameworks/Python.framework/Versions/3.12/bin/mypy'
else
  " set shell=/bin/zsh
  set guifont=JetBrainsMono\ Nerd\ Font\ Mono\ Regular\ 11
  set guioptions=rl " egmrLtT - default value,
                    " custom: right, left scroll always,
                    " because of gvim bug
  let g:os = 'linux'
endif


call plug#begin("$XDG_CONFIG_HOME/vim/bundle")
  " linter
  Plug 'dense-analysis/ale'
  " autocompleter
  Plug 'ycm-core/YouCompleteMe'
  " debugger
  Plug 'puremourning/vimspector'
  " ui
  Plug 'preservim/nerdtree'
  Plug 'sheerun/vim-polyglot'
  Plug 'ryanoasis/vim-devicons'
  Plug 'lambdalisue/glyph-palette.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " colorshemes
  Plug 'tomasiser/vim-code-dark'
  Plug 'ErichDonGubler/vim-sublime-monokai'
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
  Plug 'morhetz/gruvbox'
  " bindings
  Plug 'ervandew/supertab'
  Plug 'tmsvg/pear-tree'
  Plug 'mg979/vim-visual-multi'
  " buffers
  Plug 'zefei/vim-wintabs'
  Plug 'zefei/vim-wintabs-powerline'
  " code run
  Plug 'ZaharChernenko/vim-code-runner'
call plug#end()


colorscheme catppuccin-mocha
" colorscheme sublimemonokai
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
autocmd BufNew,BufRead *.asm set ft=tasm


augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END


" airline start
let g:airline_section_x='' " remove the filetype part
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_skip_empty_sections = 1 " remove separators for empty sections
let g:airline_powerline_fonts = 1
let g:airline_theme = 'catppuccin'
" let g:airline_theme = 'molokai'
" airline end

" ale start
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_set_signs = 1
let g:ale_set_highlights = 0
let g:ale_virtualtext_cursor = 'current'
let g:ale_linters = {
    \'python': ['pylint', 'mypy'],
    \'cpp': ['cc', 'clang', 'cppcheck'],
\}
let g:ale_fixers = {
    \'*': ['trim_whitespace'],
    \'python': ['black', 'isort'],
    \'cpp': ['clang-format']
\}
" C/C++
let g:ale_cpp_cc_options = "-std=c++2a -Wall"
let g:ale_cpp_clangd_options = "-std=c++2a -Wall"
" Python
let g:ale_python_isort_options = '--profile black'
let g:ale_python_auto_pipenv = 1
let g:ale_python_auto_poetry = 1
" ale end

" coderunner start
let g:coderunner_save_all_files_before_run = 1
let g:coderunner_refresh_nerdtree_after_run = 1
" coderunner end

" devicons start
let g:DevIconsDefaultFolderOpenSymbol=''
let g:DevIconsEnableFoldersOpenClose = 1
" devicons end

" nerdtree start
let NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer = 1
" nerdtree end

" pear-tree start
let g:pear_tree_repeatable_expand = 0
" pear-tree end

" vimspector start
let g:vimspector_sign_priority = {
    \    'vimspectorBP':          50,
    \    'vimspectorBPCond':      50,
    \    'vimspectorBPLog':       50,
    \    'vimspectorBPDisabled':  50,
    \    'vimspectorNonActivePC': 50,
    \    'vimspectorPC':          999,
    \    'vimspectorPCBP':        999,
    \ }
" vimspector end

" ycm start
let g:ycm_global_ycm_extra_conf = '$XDG_CONFIG_HOME/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_filetype_blacklist={
  \   'tagbar' : 1,
  \   'nerdtree' : 1,
  \   'markdown' : 1,
  \   'unite' : 1,
  \   'text' : 1,
  \   'csv' : 1,
  \}
" ycm end

" wintabs start
let g:wintabs_autoclose=2
" wintabs end


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
map ь m
map а f
map А F
" commands
map ч x
map Ч X
map м v
map М V
map ш i
map Ш I
map г u
map Г U
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
  tnoremap <silent> <C-k> <C-\><C-n>:wincmd k<CR>
  tnoremap <silent> <C-h> <C-\><C-n>:wincmd h<CR>
  tnoremap <silent> <C-j> <C-\><C-n>:wincmd j<CR>
  tnoremap <silent> <C-l> <C-\><C-n>:wincmd l<CR>
  " closing buffers
  noremap <silent> <D-w> :WintabsClose<CR>
  inoremap <silent> <D-w> <Esc>:WintabsClose<CR>
  " terminal
  tnoremap <silent> <C-t> <C-\><C-n>:resize 1<CR>:wincmd j<CR>
  noremap <silent> <C-t> :call OpenOrToggleTerminal()<CR><C-\><C-n>i
  inoremap <silent> <C-t> <Esc>:call OpenOrToggleTerminal()<CR><C-\><C-n>i
  " NerdTree
  noremap <silent> <C-e> :NERDTreeToggle<CR>
  inoremap <silent> <C-e> <Esc>:NERDTreeToggle<CR>i
  " code run
  noremap <silent> <C-r> :call coderunner#Run()<CR>
  inoremap <silent> <C-r> <Esc>:call coderunner#Run()<CR>
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
    tnoremap <silent> <A-k> <C-\><C-n>:wincmd k<CR>
    tnoremap <silent> <A-h> <C-\><C-n>:wincmd h<CR>
    tnoremap <silent> <A-j> <C-\><C-n>:wincmd j<CR>
    tnoremap <silent> <A-l> <C-\><C-n>:wincmd l<CR>
    " Russian
    noremap <silent> <A-л> :wincmd k<CR>
    noremap <silent> <A-р> :wincmd h<CR>
    noremap <silent> <A-о> :wincmd j<CR>
    noremap <silent> <A-д> :wincmd l<CR>
    tnoremap <silent> <A-л> <C-\><C-n>:wincmd k<CR>
    tnoremap <silent> <A-р> <C-\><C-n>:wincmd h<CR>
    tnoremap <silent> <A-о> <C-\><C-n>:wincmd j<CR>
    tnoremap <silent> <A-д> <C-\><C-n>:wincmd l<CR>
    " closing tabs
    noremap <silent> <C-h> :WintabsPrevious<CR>
    noremap <silent> <C-l> :WintabsNext<CR>
    noremap <silent> <C-w> :WintabsClose<CR>
    inoremap <silent> <C-w> <Esc>:WintabsClose<CR>
    " Russian
    noremap <silent> <C-р> :WintabsPrevious<CR>
    noremap <silent> <C-д> :WintabsNext<CR>
    noremap <silent> <C-ц> :WintabsClose<CR>
    inoremap <silent> <C-ц> <Esc>:WintabsClose<CR>
    " terminal
    " <C-w>N - normal mode in terminal (ctrl+w, shift+n)
    " все сочетания с ctrl регистронезависимые, поэтому ctrl+shift+w нельзя
    " забиндить на копирование, т.к. ctrl+c всегда остановка процесса, поэтому
    " строка ниже бесполезная
    " tnoremap <C-c> <C-W>N
    tnoremap <C-v> <C-W>"+
    tnoremap <silent> <A-t> <C-\><C-n>:resize 1<CR>:wincmd j<CR>
    noremap <silent> <A-t> :call OpenOrToggleTerminal()<CR><C-\><C-n>i
    inoremap <silent> <A-t> <Esc>:call OpenOrToggleTerminal()<CR><C-\><C-n>i
    " Russian
    tnoremap <C-м> <C-W>"+
    tnoremap <silent> <A-е> <C-\><C-n>:resize 1<CR>:wincmd j<CR>
    noremap <silent> <A-е> :call OpenOrToggleTerminal()<CR><C-\><C-n>i
    inoremap <silent> <A-е> <Esc>:call OpenOrToggleTerminal()<CR><C-\><C-n>i
    " NerdTree
    noremap <silent> <A-e> :NERDTreeToggle<CR>
    inoremap <silent> <A-e> <Esc>:NERDTreeToggle<CR>i
    " Russian
    noremap <silent> <A-у> :NERDTreeToggle<CR>
    inoremap <silent> <A-у> <Esc>:NERDTreeToggle<CR>i
    " code run
    noremap <silent> <A-r> :call coderunner#Run()<CR>
    inoremap <silent> <A-r> <Esc>:call coderunner#Run()<CR>
    " Russian
    noremap <silent> <A-к> :call coderunner#Run()<CR>
    inoremap <silent> <A-к> <Esc>:call coderunner#Run()<CR>
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
    tnoremap <silent> <Esc>k <C-\><C-n>:wincmd k<CR>
    tnoremap <silent> <Esc>h <C-\><C-n>:wincmd h<CR>
    tnoremap <silent> <Esc>j <C-\><C-n>:wincmd j<CR>
    tnoremap <silent> <Esc>l <C-\><C-n>:wincmd l<CR>
    " Russian
    noremap <silent> <Esc>л :wincmd k<CR>
    noremap <silent> <Esc>р :wincmd h<CR>
    noremap <silent> <Esc>о :wincmd j<CR>
    noremap <silent> <Esc>д :wincmd l<CR>
    tnoremap <silent> <Esc>л <C-\><C-n>:wincmd k<CR>
    tnoremap <silent> <Esc>р <C-\><C-n>:wincmd h<CR>
    tnoremap <silent> <Esc>о <C-\><C-n>:wincmd j<CR>
    tnoremap <silent> <Esc>д <C-\><C-n>:wincmd l<CR>
    " NerdTree
    noremap <silent> <Esc>e :NERDTreeToggle<CR>
    inoremap <silent> <Esc>e <Esc>:NERDTreeToggle<CR>i
    " Russian
    noremap <silent> <Esc>у :NERDTreeToggle<CR>
    inoremap <silent> <Esc>у <Esc>:NERDTreeToggle<CR>i
    " terminal
    tnoremap <silent> <Esc>t <C-\><C-n>:resize 1<CR>:wincmd j<CR>
    noremap <silent> <Esc>t :call OpenOrToggleTerminal()<CR><C-\><C-n>i
    inoremap <silent> <Esc>t <Esc>:call OpenOrToggleTerminal()<CR><C-\><C-n>i
    " Russian
    tnoremap <silent> <Esc>е <C-\><C-n>:resize 1<CR>:wincmd j<CR>
    noremap <silent> <Esc>е :call OpenOrToggleTerminal()<CR><C-\><C-n>i
    inoremap <silent> <Esc>е <Esc>:call OpenOrToggleTerminal()<CR><C-\><C-n>i
    " code run
    noremap <silent> <Esc>r :call coderunner#Run()<CR>
    inoremap <silent> <Esc>r <Esc>:call coderunner#Run()<CR>
    " Russian
    noremap <silent> <Esc>к :call coderunner#Run()<CR>
    inoremap <silent> <Esc>к <Esc>:call coderunner#Run()<CR>
  endif

  " ctrl bindings
  noremap <C-c> "+yi<Esc>
  noremap <C-x> "+c<Esc>
  " ctrl+z
  nnoremap <C-z> u
  vnoremap <C-z> <Esc>u
  inoremap <C-z> <Esc>ui
  " ctrl+a
  noremap <C-a> ggVG
  inoremap <C-a> <Esc>ggVG
  " ctrl+v
  nnoremap <C-v> a<C-r><C-o>+
  vnoremap <C-v> xa<C-r><C-o>+
  inoremap <C-v> <C-r><C-o>+
  " ctrl+s
  noremap <C-s> :w<CR>
  inoremap <C-s> <Esc>:w<CR>
  " Russian
  noremap <C-с> "+yi<Esc>
  noremap <C-ч> "+c<Esc>
  " ctrl+z
  nnoremap <C-я> u
  vnoremap <C-я> <Esc>u
  inoremap <C-я> <Esc>ui
  " ctrl+a
  noremap <C-ф> ggVG
  inoremap <C-ф> <Esc>ggVG
  " ctrl+v
  nnoremap <C-м> a<C-r><C-o>+
  vnoremap <C-м> xa<C-r><C-o>+
  inoremap <C-м> <C-r><C-o>+
  " ctrl+s
  noremap <C-ы> :w<CR>
  inoremap <C-ы> <Esc>:w<CR>
endif


function OpenOrToggleTerminal()
  " Проверяем, есть ли уже открытый терминал
  if winnr('$') > 1 && bufwinnr($"!{$SHELL}") != -1
    " Если терминал открыт, переключаемся на него
    let term_win = bufwinnr($"!{$SHELL}")
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