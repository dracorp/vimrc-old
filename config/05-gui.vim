if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

if g:MSWIN64 && has("gui_running")
    au GUIEnter * simalt ~x
endif

if has("gui_running")
    set mousehide                               " Hide the mouse when typing text
    set mouse=a                                 " normal(n) + visual(v) + insert(i) + comman line(c)
                                                " help(h) - all previous when editing help files
                                                " a - all previous
    set guioptions+=m                           " menu bar
    set guioptions+=g                           " grey menu items
    set guioptions+=t                           " include tearoff menu items
    set guioptions-=e                           " Add tab pages when indicated with 'showtabline'
    set guioptions-=T                           " exclude Toolbar

    "set noguipty                                   " Make external commands work through a pipe instead of a pseudo-tty
    "set columns=80 lines=30                        " don't inherit geometry from parent term
    set mousemodel=popup                           " right mouse button pops up a menu in the GUI

    " toggle insert mode  'normal mode with the <RightMouse>-key
    "nnoremap  <RightMouse> <Insert>
    "inoremap  <RightMouse> <ESC>

    if g:MSWIN
        set guifont=DejaVu_Sans_Mono:h10:cANSI
    elseif g:MACOS
        set guifont=Hack-Regular:h13
"        set guifont=Fira\ Code\ 11
    elseif g:UNIX
        set guifont=Hack\ 13
        set guifont=Cascadia\ Code\ 11
    endif
endif
" }}}

