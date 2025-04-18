Plug 'cdelledonne/vim-cmake'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

set virtualedit=all " cursor can be positioned where no char
" after that, x will copy to the system buffer, which I don't really need
set clipboard^=unnamed,unnamedplus
:cd %:p:h " change dir to current buffer
:ter python3-intel64 "%" " run cur file as python script


" ale start
let g:ale_lint_on_text_changed = 1
let g:ale_c_clangformat_options = "-style=file:$XDG_CONFIG_HOME/clang-format"
" ale end

" devicons start
" fix devicons bug, but non-ascii symbols will have 2-x lenght
autocmd FileType nerdtree setlocal ambiwidth=double
autocmd FileType css,scss set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" devicons end

" vimspector start
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
" vimspector end

" ycm start
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
let g:ycm_extra_conf_vim_data = [
      \  'g:ycm_python_interpreter_path'
      \]
" ycm end

" cpp start
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


function BuildCpp()
  wall
  CMakeBuild
endfunction


" I used most of run functions until I wrote vim-code-runner
function RunCpp()
  if &readonly == 0
    :wall
  endif
  !g++ -std=c++2a *.cpp
  NERDTreeRefreshRoot
  ter ./a.out
  let b:ycm_largefile = 1 " disable ycm for terminal
endfunction


function RunCpp()
  let recompile = CppCheckRecompile()
  if recompile == 1
    wall
    execute $"ter sh -c \"g++ -o output -std=c++2a *.cpp && ./output\""
  else
    ter ./output
  endif

  NERDTreeRefreshRoot
endfunction


function DebugCpp()
  let recompile = CppCheckRecompile()
  if recompile == 1
    wall
    :!g++ -o test -g -std=c++2a *.cpp
  endif

  if v:shell_error == 0
    call vimspector#Launch()
  endif
endfunction


function CppCheckRecompile()
  let recompile = 0
  if filereadable("output") == 0
    return 1
  endif

  for buf in getbufinfo({'bufmodified': 1})
    if buf.changed
      return 1
    endif
  endfor

  for file in split(globpath('.', '*.cpp'), '\n') + split(globpath('.', '*.h'), '\n')
    if strftime('%y%m%d %T', getftime('output')) < strftime('%y%m%d %T', getftime(file))
      return 1
    endif
  endfor

  return 0
endfunction
" cpp end


" python start
function GetPythonPath()
  let venv_dirs = ['.venv', 'venv', 'virtualenv']
  for dir in venv_dirs
    " if the folder was found in the current directory, the path
    " will be relative, otherwise absolute
    let check_dir = finddir(dir, ';')
    if check_dir != ''
      if check_dir == dir
        let venv_dir = $"{getcwd()}/{dir}"
      else
        let venv_dir = check_dir
      endif
      if isdirectory($"{venv_dir}/bin")
        return escape($"{venv_dir}/bin/python3", ' \')
      endif
    endif
  endfor

  if g:os == 'macos'
    return 'python3-intel64'
  endif
  return 'python3'
endfunction


function GetPython()
  if exists("b:python") == 0
    let b:python = GetPythonPath()
  endif

  if g:ycm_python_interpreter_path != b:python
    let g:ycm_python_interpreter_path = b:python
    YcmRestartServer
  endif
endfunction


function RunPython()
  wall
  execute $"ter {b:python} {escape(expand('%'), ' \')}"
  NERDTreeRefreshRoot
endfunction


augroup python
  autocmd!
  autocmd BufEnter *.py silent! call GetPython()
augroup END

" <buffer> applies to current buffer only
autocmd FileType python noremap <buffer> <C-r> :call RunPython()<CR>
autocmd FileType python inoremap <buffer> <C-r> <Esc>:call RunPython()<CR>
" python end


function RunJS()
  wall
  execute $"ter node {escape(expand('%'), ' \')}"
  NERDTreeRefreshRoot
endfunction


function SwitchBuffer(act)
  if &filetype == 'nerdtree'
    wincmd l
    execute a:act
  else
    execute a:act
  endif
endfunction


function RunVim()
  NERDTree | wincmd p
  if g:os == 'linux'
    " gvim has a bug where when opening vim via a file venv is not detected
    " or I didn't figure it out then
    let b:python = GetPythonPath()
    let g:ycm_python_interpreter_path = b:python
    " without normal! there will be an error that the plugin is not loaded
    normal! YcmRestartServer
  endif
endfunction


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


function ToggleTerminal(is_from_insert)
    " checking if there is already an open VISIBLE terminal, then hide,
    " otherwise create or show buffer
    let term_window_number = bufwinnr($"!{$SHELL}")
    if term_window_number != -1
        let s:term_window_height = winheight(term_window_number)
        execute $"{term_window_number} hide"
        if a:is_from_insert == 1
            call feedkeys("i", 'n')
        endif
    else
        let previous_nerdtree_status = g:NERDTree.IsOpen()
        let term_buffer_number = bufnr($"!{$SHELL}")
        NERDTreeClose
        if term_buffer_number != -1
            execute $"topleft sbuffer {term_buffer_number}"
            execute $"{bufwinnr(term_buffer_number)} resize {s:term_window_height}"
            call feedkeys("i", 'n')
        else
            topleft ter
            resize 15
        endif

        if previous_nerdtree_status == 1
            NERDTreeFocus
            wincmd p
        endif
    endif
endfunction


" not used because you can't highlight, just click
function FocusOnClick()
    let mouse_pos = getmousepos()
    call cursor(mouse_pos.line, mouse_pos.column)
endfunction
