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
  " terminal
  Plug 'voldikss/vim-floaterm'
  " search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " git
  Plug 'tpope/vim-fugitive'
  Plug 'shumphrey/fugitive-gitlab.vim' " for github support GBrowse
  Plug 'tpope/vim-rhubarb' " for github support GBrowse
  " code run
  Plug 'ZaharChernenko/vim-code-runner'
call plug#end()


execute $"source {$XDG_CONFIG_HOME}/vim/settings/functions.vim"
execute $"source {$XDG_CONFIG_HOME}/vim/settings/mappings.vim"


filetype plugin indent on " enable filetype detecting, indents and plugins loading
syntax enable " syntax highlighting
" set is used for setting internal vim variables
set colorcolumn=100 " show a vertical line at column 100
set completeopt-=preview " disable preview window
set display+=lastline " for long lines
set encoding=utf-8
set expandtab " convert tabs to spaces.
set fillchars+=eob:\ " " replace ~ at end of buffer with a space
set fillchars+=vert:\│ " use │ for vertical window splits
set history=1000
set mouse=a " for the weak in spirit
set nobackup
set nohlsearch " turn off the backlight after searching
set noswapfile
set nowrap " disable line wrapping
set number " show numbers column
" define how many spaces will be inserted when pressed <Tab> at the beginning of a line and when shifting
set shiftwidth=4
set sidescroll=5
set signcolumn=yes " always show the sign column for linter marks
set smartindent
set smarttab
" define how many spaces will be inserted when pressed <Tab> in insert mode except shiftwidth case
" by this formula: softtabstop - (one_based_column_index - 1) % softtabstop
set softtabstop=4
set t_Co=256 " 256-color mode in the terminal, default is 16
set tabstop=4 " define the visual width of the tab character in spaces
set undolevels=1000
set whichwrap+=<,>,h,l,[,] " moving to the next line after reaching the end
set wildchar=<Tab>
set wildmenu " autocompletion suggestions in command mode


if has('macunix')
  set guifont=JetBrainsMono\ Nerd\ Font\ Regular:h13
  set linespace=3
else
  set guifont=JetBrainsMono\ Nerd\ Font\ Mono\ Regular\ 11
  set guioptions=rl " egmrLtT - default value,
                    " custom: right, left scroll always,
                    " because of gvim bug
  " browser for GBrowse and gx
  let g:netrw_browsex_viewer = "yandex-browser"
endif

autocmd BufNew,BufRead *.asm set ft=tasm
colorscheme catppuccin-mocha
" colorscheme codedark
" colorscheme sublimemonokai

" airline start
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_x='' " remove the filetype part
let g:airline_skip_empty_sections = 1 " remove separators for empty sections
let g:airline_powerline_fonts = 1
let g:airline_theme = 'catppuccin'
" let g:airline_theme = 'codedark'
" let g:airline_theme = 'molokai'
" airline end

" ale start
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_completion_enabled = 0
let g:ale_cpp_cc_options = "-std=c++2a -Wall"
let g:ale_cpp_clangd_options = "-std=c++2a -Wall"
let g:ale_fixers = {
    \ '*': ['trim_whitespace'],
    \ 'python': ['black', 'isort'],
    \ 'cpp': ['clang-format']
\}
let g:ale_fix_on_save = 1
let g:ale_linters = {
    \ 'python': ['pylint', 'mypy'],
    \ 'cpp': ['cc', 'clang', 'cppcheck'],
\ }
let g:ale_lint_on_save = 1
let g:ale_set_highlights = 0
let g:ale_set_signs = 1
let g:ale_virtualtext_cursor = 'current'
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_warn_about_trailing_blank_lines = 0
" ale end

" coderunner start
let g:coderunner_save_all_files_before_run = 1
" coderunner end

" devicons start
let g:DevIconsDefaultFolderOpenSymbol=''
let g:DevIconsEnableFoldersOpenClose = 1
" devicons end

" fzf start
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'VertSplit'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
\ }
" fzf end

" glyph-palette start
autocmd FileType nerdtree,startify call glyph_palette#apply()
" glyph-palette end

" nerdtree start
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
" nerdtree end

" pear-tree start
let g:pear_tree_repeatable_expand = 0
" pear-tree end

" vimspector start
let g:vimspector_sign_priority = {
    \ 'vimspectorBP':          50,
    \ 'vimspectorBPCond':      50,
    \ 'vimspectorBPLog':       50,
    \ 'vimspectorBPDisabled':  50,
    \ 'vimspectorNonActivePC': 50,
    \ 'vimspectorPC':          999,
    \ 'vimspectorPCBP':        999,
\ }
" vimspector end

" ycm start
autocmd FileType c,cpp,python let b:ycm_hover = {
    \ 'command': 'GetDoc',
    \ 'syntax': &filetype,
    \ 'popup_params': {
        \ 'border': [],
        \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
    \ },
\ }
command! YcmFindDoc call youcompleteme#finder#FindSymbol('document')
command! YcmFindProj call youcompleteme#finder#FindSymbol('workspace')
highlight clear YcmErrorSign
highlight clear YcmWarningSign
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_filetype_blacklist = {
    \ 'tagbar' : 1,
    \ 'nerdtree' : 1,
    \ 'markdown' : 1,
    \ 'unite' : 1,
    \ 'text' : 1,
    \ 'csv' : 1,
\ }
let g:ycm_global_ycm_extra_conf = '$XDG_CONFIG_HOME/ycm/.ycm_extra_conf.py'
" ycm end

" wintabs start
let g:wintabs_autoclose=2
" wintabs end
