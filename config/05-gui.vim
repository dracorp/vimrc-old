if &t_Co > 2 || has('gui_running')
    syntax on                                   " Enable syntax highlighting.
    set hlsearch
endif

if g:MSWIN64 && has('gui_running')
    augroup GUI
        au!
        au GUIEnter * simalt ~x
    augroup END
else
    " Maximize GVim on start
    if has('gui_running')
    set lines=999 columns=999
    endif
endif

if has('gui_running')
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
        set guifont=FiraCode-Regular:h13
        set guifont=agaveNerdFontComplete-r:h15
        set guifont=AgaveNF-Regular:h15
    elseif g:UNIX
        set guifont=Hack\ 13
        set guifont=Cascadia\ Code\ 12
        set guifont=Iosevka\ Semi-Bold\ 12
        set guifont=JetBrains\ Mono\ 12
    endif
endif
" }}}
