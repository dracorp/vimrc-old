" Vim Only Terminal Tweaks: Colors, cursor shape, and tmux

" Enable 256 color terminal
set t_Co=256
" more colors
if &term =~# 'xterm'
    if has('terminfo')
        set t_Sf="\<Esc>[3%p1%dm"
        set t_Sb="\<Esc>[4%p1%dm"
    else
        set t_Sf="\<Esc>[3%dm"
        set t_Sb="\<Esc>[4%dm"
    endif
endif

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
