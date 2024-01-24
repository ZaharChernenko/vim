" JetBrainsMono doesn't support default vimspector signs
sign define vimspectorBP text=o             texthl=WarningMsg
sign define vimspectorBPCond text=o?        texthl=WarningMsg
sign define vimspectorBPLog text=!!         texthl=SpellRare
sign define vimspectorBPDisabled text=o!    texthl=LineNr
sign define vimspectorPC text=\ >           texthl=MatchParen
sign define vimspectorPCBP text=o>          texthl=MatchParen
sign define vimspectorCurrentThread text=>  texthl=MatchParen
sign define vimspectorCurrentFrame text=>   texthl=Special


function RunCpp()
  if &readonly == 0
    :wall
  endif
  !g++ -std=c++2a *.cpp
  NERDTreeRefreshRoot
  ter ./a.out
  let b:ycm_largefile = 1 "disable ycm for terminal
endfunction
