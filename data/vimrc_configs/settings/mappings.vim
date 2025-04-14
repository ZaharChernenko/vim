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

if has('macunix')
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
  autocmd FileType floaterm noremap <buffer> <silent> <ScrollWheelDown> :call ScrollDown()<CR>
  autocmd FileType floaterm noremap <buffer> <silent> <ScrollWheelUp> :call ScrollUp()<CR>
  autocmd FileType floaterm noremap <buffer> <silent> <D-h> :FloatermPrev<CR>
  autocmd FileType floaterm noremap <buffer> <silent> <D-l> :FloatermNext<CR>
  autocmd FileType floaterm noremap <buffer> <silent> <D-t> :FloatermNew<CR>
  autocmd FileType floaterm tnoremap <buffer> <silent> <D-h> <C-\><C-n>:FloatermPrev<CR>
  autocmd FileType floaterm tnoremap <buffer> <silent> <D-l> <C-\><C-n>:FloatermNext<CR>
  autocmd FileType floaterm tnoremap <buffer> <silent> <D-t> <C-\><C-n>:FloatermNew<CR>
  tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
  noremap <silent> <C-t> :FloatermToggle<CR>
  inoremap <silent> <C-t> <Esc>:FloatermToggle<CR>
  " fzf
  autocmd FileType fzf tnoremap <buffer> <silent> <ScrollWheelRight> <NOP>
  autocmd FileType fzf tnoremap <buffer> <silent> <ScrollWheelLeft> <NOP>
  autocmd FileType fzf tnoremap <buffer> <C-t> <ESC>
  " NerdTree
  noremap <silent> <C-e> :NERDTreeToggle<CR>
  inoremap <silent> <C-e> <Esc>:NERDTreeToggle<CR>i
  " code run
  noremap <silent> <C-r> :call coderunner#Run()<CR>
  inoremap <silent> <C-r> <Esc>:call coderunner#Run()<CR>
else
  if has("gui_running")
    let g:SuperTabMappingForward = '<A-tab>'
    noremap <A-ScrollWheelUp> <ScrollWheelRight>
    noremap <A-ScrollWheelDown> <ScrollWheelLeft>

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
    tnoremap <silent> <A-t> <C-\><C-n>:call ToggleTerminal(0)<CR>
    noremap <silent> <A-t> :call ToggleTerminal(0)<CR>
    inoremap <silent> <A-t> <Esc>:call ToggleTerminal(1)<CR>
    " Russian
    tnoremap <C-м> <C-W>"+
    tnoremap <silent> <A-е> <C-\><C-n>:call ToggleTerminal(0)<CR>
    noremap <silent> <A-е> :call ToggleTerminal(0)<CR>
    inoremap <silent> <A-е> <Esc>:call ToggleTerminal(1)<CR>
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
    tnoremap <silent> <Esc>t <C-\><C-n>:call ToggleTerminal(0)<CR>
    noremap <silent> <Esc>t :call ToggleTerminal(0)<CR>
    inoremap <silent> <Esc>t <Esc>:call ToggleTerminal(1)<CR>
    " Russian
    tnoremap <silent> <Esc>е <C-\><C-n>:call ToggleTerminal(0)<CR>
    noremap <silent> <Esc>е :call ToggleTerminal(0)<CR>
    inoremap <silent> <Esc>е <Esc>:call ToggleTerminal(1)<CR>
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

