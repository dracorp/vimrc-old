" vi: ft=vim
" $HOME - user's home directory
" $VIM - vim's installation direcotry
let g:MSWIN = has("win16") || has("win32")   || has("win64")    || has("win95")
let g:UNIX  = has("unix")  || has("macunix") || has("win32unix")

if g:UNIX
    let  vimrc_dir = $HOME . '/.vim/'
elseif g:MSWIN
    language messages en
    " change '\' to '/' to avoid interpretation as escape character
    if match( substitute( expand("<sfile>"), '\', '/', 'g' ),
        \   substitute( expand("$HOME"),   '\', '/', 'g' ) ) == 0
        " configuration held in user's home directory
        let vimrc_dir = $HOME . '\vimfiles\'
    else
        " configuration held in vim's installation directory
        let vimrc_dir = $VIM . '\vimfiles\'
        set runtimepath-=~/vimfiles
    endif

    " default file format for all OS
    set fileformat=unix
endif

let s:vimrc = vimrc_dir . 'vimrc.common.vim'

if filereadable(s:vimrc)
    execute ':source' s:vimrc
endif
