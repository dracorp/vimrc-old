" vi: ft=vim
if has('unix')
    let  vimrc_dir = $HOME . "/.vim/"
elseif has('win32')
    let  vimrc_dir = $HOME . "/vimfiles/"
endif

let vimrc = vimrc_dir . "vimrc.common"
let bundle_dir = vimrc_dir . "bundle/"

if filereadable(vimrc)
    execute ":source" vimrc
endif
