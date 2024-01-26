Plug 'cdelledonne/vim-cmake'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'


set virtualedit=all " cursor can be positioned where no char

" fix devicons bug, but non-ascii symbols will have 2-x lenght
autocmd FileType nerdtree setlocal ambiwidth=double
autocmd FileType css,scss set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" vimspector
" JetBrainsMono doesn't support default vimspector signs
sign define vimspectorBP text=o             texthl=WarningMsg
sign define vimspectorBPCond text=o?        texthl=WarningMsg
sign define vimspectorBPLog text=!!         texthl=SpellRare
sign define vimspectorBPDisabled text=o!    texthl=LineNr
sign define vimspectorPC text=\ >           texthl=MatchParen
sign define vimspectorPCBP text=o>          texthl=MatchParen
sign define vimspectorCurrentThread text=>  texthl=MatchParen
sign define vimspectorCurrentFrame text=>   texthl=Special
let g:vimspector_enable_mappings = 'HUMAN'
" vimspector


let g:ale_lint_on_text_changed = 1


" ycm
let g:ycm_language_server = []
let g:ycm_language_server += [
  \   {
  \     'name': 'css',
  \     'cmdline': [ expand('~/.local/share/vim-lsp-settings/servers/vscode-css-language-server/vscode-css-language-server'), '--stdio' ],
  \     'filetypes': ['css', 'sass'],
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'html',
  \     'cmdline': [ expand('~/.local/share/vim-lsp-settings/servers/vscode-html-language-server/vscode-html-language-server'), '--stdio' ],
  \     'filetypes': ['html'],
  \   },
  \ ]
" ycm

" cmake
let g:cmake_console_position = 'horizontal'
let g:cmake_jump_on_completion = 0
let g:cmake_jump = 0
let g:cmake_root_markers = []
autocmd Filetype cpp noremap <buffer> <C-b> :call BuildCpp()<CR>
autocmd Filetype cpp inoremap <buffer> <C-b> <Esc>:call BuildCpp()<CR>
autocmd Filetype cpp noremap <buffer> <A-b> :call BuildCpp()<CR>
autocmd Filetype cpp inoremap <buffer> <A-b> <Esc>:call BuildCpp()<CR>
autocmd Filetype cpp noremap <buffer> <Esc>b :call BuildCpp()<CR>
autocmd Filetype cpp inoremap <buffer> <Esc>b <Esc>:call BuildCpp()<CR>
" cmake


function BuildCpp()
  wall
  CMakeBuild
endfunction


function RunCpp()
  if &readonly == 0
    :wall
  endif
  !g++ -std=c++2a *.cpp
  NERDTreeRefreshRoot
  ter ./a.out
  let b:ycm_largefile = 1 " disable ycm for terminal
endfunction


":cd %:p:h - change dir to current buffer
":ter python3-intel64 "%" "

