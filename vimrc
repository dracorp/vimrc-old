"
" To start vim without loading any .vimrc or plugins, use:
"   vim -u NONE
"
" To test timing startup
"   vim --startuptime start.log

" Use Vim settings, rather then Vi settings. This must be first, because it changes other options as a side effect.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
    " `:set nocp` has many side effects. Therefore this should be done
    " only when 'compatible' is set.
    set nocompatible
endif

" Set main configuration directory as parent directory
let $VIM_PATH = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! s:source_file(path, ...) "{{{
	" Source user configuration files with set/global sensitivity
	let use_global = get(a:000, 0, ! has('vim_starting'))
	let abspath = resolve($VIM_PATH . '/' . a:path)
	if ! use_global
		execute 'source' fnameescape(abspath)
		return
	endif

	let tempfile = tempname()
	let content = map(readfile(abspath),
		\ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")
	try
		call writefile(content, tempfile)
		execute printf('source %s', fnameescape(tempfile))
	finally
		if filereadable(tempfile)
			call delete(tempfile)
		endif
	endtry
endfunction "}}}

" Initialize startup settings
if has('vim_starting')
	" Use spacebar as leader and ; as secondary-leader
	" Required before loading plugins!
	"let g:mapleader="\<Space>"
	let g:maplocalleader=';'

	" Vim only, Linux terminal settings
	if ! has('nvim') && ! has('gui_running') && ! has('win32') && ! has('win64')
        if filereadable($VIM_PATH . '/config/00-terminal.vim')
            call s:source_file('config/00-terminal.vim')
        endif
	endif
endif

" Load user scripts with confidential information
" or pre-settings like g:elite_mode
if filereadable($VIM_PATH . '/.vault.vim')
	call s:source_file('.vault.vim')
endif

" Initialize plugin-manager and load main config files
if filereadable($VIM_PATH . '/config/01-init.vim')
    call s:source_file('config/01-init.vim')
endif
if filereadable($VIM_PATH . '/config/02-plugins.vim')
    call s:source_file('config/02-plugins.vim')
endif

" Initialize all my configurations
if filereadable($VIM_PATH . '/config/03-general.vim')
    call s:source_file('config/03-general.vim')
endif
if filereadable($VIM_PATH . '/config/04-filetype.vim')
    call s:source_file('config/04-filetype.vim')
endif
if filereadable($VIM_PATH . '/config/05-gui.vim')
    call s:source_file('config/05-gui.vim')
endif
if filereadable($VIM_PATH . '/config/06-functions.vim')
    call s:source_file('config/06-functions.vim')
endif
if filereadable($VIM_PATH . '/config/07-commands.vim')
    call s:source_file('config/07-commands.vim')
endif
if filereadable($VIM_PATH . '/config/08-mappings.vim')
    call s:source_file('config/08-mappings.vim')
endif

" Load user custom local settings
if filereadable($VIM_PATH . '/config/99-local.vim')
	call s:source_file('config/99-local.vim')
endif

if filereadable(vimrc_dir . "vimrc.local")
    execute ":source " . vimrc_dir . "vimrc.local"
endif

set secure
