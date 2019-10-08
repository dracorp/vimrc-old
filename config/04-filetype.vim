" Filetype specific handling
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile */nginx-conf/**.conf set ft=nginx
au BufRead *access.log* setf httplog
au BufRead *error.log* setf httplog
" Parse the php-fpm.conf file as a dosini
autocmd BufRead,BufNewFile /etc/php/* set syntax=dosini
au BufRead *.vmb set ft=vim
autocmd BufNewFile,BufRead ~/.conky/* if expand('%:e') == '' | set syntax=conkyrc | endif

if has("autocmd")

    augroup change_dir "{{{
        au!
        " The current directory is the directory of the file in the current window.
        autocmd BufEnter * :lchdir %:p:h
    augroup end "}}}

    augroup jump_last_position "{{{
        au!
        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    augroup end "}}}

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd FileType vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd FileType vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
"        autocmd FileType vim nnoremap <buffer> <F12> :source %<CR>
    augroup end "}}}

    augroup awk_files " {{{
        au!
        autocmd FileType awk nnoremap <buffer> <F12> :!gawk -f %<CR>
    augroup end " }}}

    augroup xdefaults_files " {{{
        au!
        autocmd FileType xdefaults nnoremap <buffer> <F12> :!xrdb -load %<CR>
        augroup end " }}}

    augroup xmodmap_files " {{{
        au!
        autocmd FileType xmodmap nnoremap <buffer> <F12> :!xmodmap %<CR>
        augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd FileType css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup xml_files "{{{
        au!
        au FileType xml setlocal foldmethod=syntax
    augroup end "}}}

    augroup go "{{{
    autocmd!

    " Show by default 4 spaces for a tab
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

    " :GoBuild and :GoTestCompile
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

    " :GoTest
    autocmd FileType go nmap <leader>t  <Plug>(go-test)

    " :GoRun
    autocmd FileType go nmap <leader>r  <Plug>(go-run)

    " :GoDoc
    autocmd FileType go nmap <Leader>d <Plug>(go-doc)

    " :GoCoverageToggle
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

    " :GoInfo
    autocmd FileType go nmap <Leader>i <Plug>(go-info)

    " :GoMetaLinter
    autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

    " :GoDef but opens in a vertical split
    autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
    " :GoDef but opens in a horizontal split
    autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

    " :GoAlternate  commands :A, :AV, :AS and :AT
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
    augroup end "}}}

    augroup pkgbuild "{{{
        au!
        au BufRead,BufNewFile PKGBUILD set ft=sh syntax=PKGBUILD
        au BufRead,BufNewFile *.PKGBUILD set ft=sh syntax=PKGBUILD
        au BufRead,BufNewFile PKGBUILD SyntasticCheck off
    augroup end "}}}

    augroup sh "{{{
        au!
        au FileType sh let g:sh_fold_enabled=5
        au FileType sh let g:is_bash=1
        au FileType sh set foldmethod=syntax
    augroup end "}}}

    augroup filetypedetect "{{{
        autocmd BufNewFile,BufRead */playbooks/*.{yml,yaml} setfiletype yaml.ansible
        autocmd BufNewFile,BufRead */inventory/*            setfiletype ansible_hosts
        autocmd BufNewFile,BufRead */templates/*.{yaml,tpl} setfiletype yaml.gotexttmpl

        autocmd BufNewFile,BufRead *.hcl                setfiletype terraform
        autocmd BufNewFile,BufRead yarn.lock            setfiletype yaml
        autocmd BufNewFile,BufRead */.kube/config       setfiletype yaml
        autocmd BufNewFile,BufRead *.postman_collection setfiletype json
        autocmd BufNewFile,BufRead .tern-{project,port} setfiletype json
        autocmd BufNewFile,BufRead *.js.map             setfiletype json
        autocmd BufNewFile,BufRead .jsbeautifyrc        setfiletype json
        autocmd BufNewFile,BufRead .eslintrc            setfiletype json
        autocmd BufNewFile,BufRead .jscsrc              setfiletype json
        autocmd BufNewFile,BufRead .babelrc             setfiletype json
        autocmd BufNewFile,BufRead .watchmanconfig      setfiletype json
        autocmd BufNewFile,BufRead .buckconfig          setfiletype toml
        autocmd BufNewFile,BufRead .flowconfig          setfiletype ini
        autocmd BufNewFile,BufRead Jenkinsfile          setfiletype groovy
        autocmd BufNewFile,BufRead Tmuxfile,tmux/config setfiletype tmux
        autocmd BufNewFile,BufRead Brewfile             setfiletype ruby
    augroup end "}}}
endif

