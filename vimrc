" vi: ft=vim
" $HOME - user's home directory
" $VIM - vim's installation direcotry
if has('unix')
    let  vimrc_dir = $HOME . '/.vim/'
elseif has('win32')
    " configuration held in user's home directory
    "let  vimrc_dir = $HOME . '/vimfiles/'

    " configuration held in vim's installation directory
    let vimrc_dir = $VIM . '/vimfiles/'
    set runtimepath-=~/vimfiles

    " default file format for all OS
    set fileformat=unix
endif

let vimrc = vimrc_dir.'vimrc.common.vim'
"let bundle_dir = vimrc_dir.'bundle/'

if filereadable(vimrc)
    execute ':source' vimrc
endif
