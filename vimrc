" vi: ft=vim
if has('unix')
    let  g:vimrc_dir = $HOME . "/.vim/"
elseif has('win32')
    let  g:vimrc_dir = $HOME . "/vimfiles/"
endif

let g:vimrc = g:vimrc_dir."vimrc.common"
let g:bundle_dir = g:vimrc_dir."bundle/"

if filereadable(vimrc)
    execute ":source" g:vimrc
endif
