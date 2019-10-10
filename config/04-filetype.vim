" Filetype specific handling
if has("au")

    augroup change_dir "{{{
        au!
        " The current directory is the directory of the file in the current window.
        au BufEnter * :lchdir %:p:h
    augroup END "}}}

    augroup jump_last_position "{{{
        au!
        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    augroup END "}}}

    augroup vim_files "{{{
        au!
        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        au FileType vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        au FileType vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
"        au FileType vim nnoremap <buffer> <F12> :source %<CR>
    augroup END "}}}

    augroup awk_files " {{{
        au!
        au FileType awk nnoremap <buffer> <F12> :!gawk -f %<CR>
    augroup END " }}}

    augroup xdefaults_files " {{{
        au!
        au FileType xdefaults nnoremap <buffer> <F12> :!xrdb -load %<CR>
        augroup END " }}}

    augroup xmodmap_files " {{{
        au!
        au FileType xmodmap nnoremap <buffer> <F12> :!xmodmap %<CR>
        augroup END " }}}

    augroup css_files "{{{
        au!
        au FileType css,less setlocal foldmethod=marker foldmarker={,}
    augroup END "}}}

    augroup xml_files "{{{
        au!
        au FileType xml setlocal foldmethod=syntax
    augroup END "}}}

    augroup go "{{{
    au!
    " Show by default 4 spaces for a tab
    au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
    " :GoBuild and :GoTestCompile
    au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    " :GoTest
    au FileType go nmap <leader>t  <Plug>(go-test)
    " :GoRun
    au FileType go nmap <leader>r  <Plug>(go-run)
    " :GoDoc
    au FileType go nmap <Leader>d <Plug>(go-doc)
    " :GoCoverageToggle
    au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
    " :GoInfo
    au FileType go nmap <Leader>i <Plug>(go-info)
    " :GoMetaLinter
    au FileType go nmap <Leader>l <Plug>(go-metalinter)
    " :GoDef but opens in a vertical split
    au FileType go nmap <Leader>v <Plug>(go-def-vertical)
    " :GoDef but opens in a horizontal split
    au FileType go nmap <Leader>s <Plug>(go-def-split)
    " :GoAlternate  commands :A, :AV, :AS and :AT
    au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
    augroup END "}}}

    augroup pkgbuild "{{{
        au!
        au BufRead,BufNewFile PKGBUILD set ft=sh syntax=PKGBUILD
        au BufRead,BufNewFile *.PKGBUILD set ft=sh syntax=PKGBUILD
        au BufRead,BufNewFile PKGBUILD SyntasticCheck off
    augroup END "}}}

    augroup sh "{{{
        au!
        au FileType sh let g:sh_fold_enabled=5
        au FileType sh let g:is_bash=1
        au FileType sh set foldmethod=syntax
    augroup END "}}}

    augroup json "{{{
        au!
        au FileType json setlocal foldmethod=syntax
    augroup END "}}}

    augroup filetypedetect "{{{
        au BufNewFile,BufRead */playbooks/*.{yml,yaml} setfiletype yaml.ansible
        au BufNewFile,BufRead */inventory/*            setfiletype ansible_hosts
        au BufNewFile,BufRead */templates/*.{yaml,tpl} setfiletype yaml.gotexttmpl
        au BufNewFile,BufRead *.hcl                    setfiletype terraform
        au BufNewFile,BufRead yarn.lock                setfiletype yaml
        au BufNewFile,BufRead */.kube/config           setfiletype yaml
        au BufNewFile,BufRead *.postman_collection     setfiletype json
        au BufNewFile,BufRead .tern-{project,port}     setfiletype json
        au BufNewFile,BufRead *.js.map                 setfiletype json
        au BufNewFile,BufRead .jsbeautifyrc            setfiletype json
        au BufNewFile,BufRead .eslintrc                setfiletype json
        au BufNewFile,BufRead .jscsrc                  setfiletype json
        au BufNewFile,BufRead .babelrc                 setfiletype json
        au BufNewFile,BufRead .watchmanconfig          setfiletype json
        au BufNewFile,BufRead .buckconfig              setfiletype toml
        au BufNewFile,BufRead .flowconfig              setfiletype ini
        au BufNewFile,BufRead Jenkinsfile              setfiletype groovy
        au BufNewFile,BufRead Tmuxfile,tmux/config     setfiletype tmux
        au BufNewFile,BufRead Brewfile                 setfiletype ruby
        au BufRead,BufNewFile /etc/nginx/*             setfiletype nginx
        au BufRead,BufNewFile */nginx-conf/**.conf     setfiletype nginx
        au BufRead *access.log*                        setfiletype httplog
        au BufRead *error.log*                         setfiletype httplog
        au BufRead *.vmb                               setfiletype vim
        au BufRead,BufNewFile /etc/php/*               set syntax=dosini
        au BufNewFile,BufRead ~/.conky/* if expand('%:e') == '' | set syntax=conkyrc | endif
    augroup END "}}}

endif

