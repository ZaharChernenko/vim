function PreSetup()
    if has('gui_running')
        call PreSetupGUI()
    endif
endfunction


function PreSetupGUI()
    if has('macunix')
        set guifont=JetBrainsMono\ Nerd\ Font\ Regular:h13
        set linespace=3
    else
        set guifont=JetBrainsMono\ Nerd\ Font\ Mono\ Regular\ 11
        " egmrLtT - default value, custom: right, left scroll always because of gvim bug
        set guioptions=rl
        " browser for GBrowse and gx
        let g:netrw_browsex_viewer = "yandex-browser"
    endif
endfunction


function PostSetup()
    " this is necessary because gvim opens the home directory by default
    cd %:p:h
    " Start NERDTree and put the cursor back in the other window.
    NERDTree | wincmd p
    " if you don't disable this combination, then the second key will be expected in visual mode
    " check it by launch :verbose map a
    unmap a%
endfunction


" these functions are used when ScrollWheelDown and ScrollWheelUp do not work by default
function ScrollDown()
    call win_execute(getmousepos().winid, "normal! \<C-E>")
endfunction


function ScrollUp()
    call win_execute(getmousepos().winid, "normal! \<C-Y>")
endfunction
