" these functions are used when ScrollWheelDown and ScrollWheelUp do not work by default.
function ScrollDown()
    call win_execute(getmousepos().winid, "normal! \<C-E>")
endfunction


function ScrollUp()
    call win_execute(getmousepos().winid, "normal! \<C-Y>")
endfunction

