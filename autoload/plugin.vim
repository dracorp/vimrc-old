" Auxilary function to chech if directory of plugin exists and is int runtimepath {{{2
" There is side efect with on-demand loading on both conditions

if exists('g:loaded_plugin')
  finish
endif
let g:loaded_plugin = 1

let s:cpo_save = &cpo
set cpo&vim

if exists('g:pluginIsEnabledDirectory')
    let s:pluginIsEnabledDirectory = g:pluginIsEnabledDirectory
elseif exists('g:bundle_dir')
    let s:pluginIsEnabledDirectory = g:bundle_dir
else
    echoerr('The variable neither g:bundle_dir nor g:pluginIsEnabledDirectory is not defined')
endif

if exists('g:pluginIsEnabledVerbose')
    let s:pluginIsEnabledVerbose = g:pluginIsEnabledVerbose
else
    let s:pluginIsEnabledVerbose = 0
endif

function! plugin#isEnabled(directory, ...)
    let a:verbose   = get(a:, 1, 0)
    let fullDir = expand(s:pluginIsEnabledDirectory . "/" . a:directory)
    if s:pluginIsEnabledVerbose || a:verbose
        echohl WarningMsg
        echo "Checking the directory " . fullDir . ":"
        echohl None
    endif
    let retval = isdirectory(fullDir)
    if !retval
        if s:pluginIsEnabledVerbose || a:verbose
            echohl WarningMsg
            echo "\t* directory does not exist"
            echohl None
        endif
        return retval
    endif
    if s:pluginIsEnabledVerbose || a:verbose
        echo "\t* directory exists"
    endif
    let dict = {}
    for path in split(&runtimepath,',')
        let path = substitute(path,'/$','','')
        let dict[path] = 1
    endfor
    if has_key(dict,fullDir)
        if s:pluginIsEnabledVerbose || a:verbose
            echo "\t* runtimepath contains directory"
        endif
        return 1
    endif
    if s:pluginIsEnabledVerbose || a:verbose
        echohl WarningMsg
        echo "\t* runtimepath does not contain directory"
        echohl None
    endif
    return 0
endfunction
"}}}

let &cpo = s:cpo_save
unlet s:cpo_save
