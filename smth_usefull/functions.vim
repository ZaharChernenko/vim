function RunCpp()
  if &readonly == 0
    :wall
  endif
  !g++ -std=c++2a *.cpp
  NERDTreeRefreshRoot
  ter ./a.out
  let b:ycm_largefile = 1 "disable ycm for terminal
endfunction
