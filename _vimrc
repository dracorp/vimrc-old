" vi: ft=vim
if has('unix')
    let  vimrc = $HOME . "/.vim/vimrc.common"
elseif has('win32')
    let  vimrc = $HOME . "/vimfiles/vimrc.common"
endif

if filereadable(vimrc)
    execute ":source" vimrc
endif
