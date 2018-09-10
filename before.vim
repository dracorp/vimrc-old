" Auxilary function to chech if directory of plugin exists and is int runtimepath {{{2
" There is side efect with on-demand loading on both conditions
let g:isPluginEnabledVerbose=0
function! IsPluginEnabled(directory, ...)
    let a:verbose   = get(a:, 1, 0)
    let fullDir = expand(g:bundle_dir . "/" . a:directory)
    if g:isPluginEnabledVerbose || a:verbose
        echohl WarningMsg
        echo "Checking the directory " . fullDir . ":"
        echohl None
    endif
    let retval = isdirectory(fullDir)
    if !retval
        if g:isPluginEnabledVerbose || a:verbose
            echohl WarningMsg
            echo "\t* directory does not exist"
            echohl None
        endif
        return retval
    endif
    if g:isPluginEnabledVerbose || a:verbose
        echo "\t* directory exists"
    endif
    let dict = {}
    for path in split(&runtimepath,',')
        let path = substitute(path,'/$','','')
        let dict[path] = 1
    endfor
    if has_key(dict,fullDir)
        if g:isPluginEnabledVerbose || a:verbose
            echo "\t* runtimepath contains directory"
        endif
        return 1
    endif
    if g:isPluginEnabledVerbose || a:verbose
        echohl WarningMsg
        echo "\t* runtimepath does not contain directory"
        echohl None
    endif
    return 0
endfunction
"}}}
