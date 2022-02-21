" Functions
"
" Exclamation mark(!) means that function replace previous
let g:quickfix_is_open = 0
function! s:QuickfixToggle() "{{{
    " Toggle the quickfix window
    " From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}
let g:last_fold_column_width = 4                " Pick a sane default for the foldcolumn
function! FoldColumnToggle() "{{{
    " Toggle the foldcolumn
    " From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
    if &foldcolumn
        let g:last_fold_column_width = &foldcolumn
        setlocal foldcolumn=0
    else
        let &l:foldcolumn = g:last_fold_column_width
    endif
endfunction
" }}}
function! CheckReadonly() "{{{
" Do not allow on any modifications read only files
    if version >= 600
        if &readonly
            setlocal nomodifiable
        endif
    endif
endfunction
"}}}
function! ChangeFileencoding() "{{{
    let encodings = ['cp1250','utf-8','iso8859-2','iso8859-1','iso8859-15']
    let prompt_encs = []
    let index = 0
    while index < len(encodings)
       call add(prompt_encs, index.'. '.encodings[index])
       let index = index + 1
    endwhile
    let choice = inputlist(prompt_encs)
    if choice >= 0 && choice < len(encodings)
        execute 'e ++enc='.encodings[choice].' %:p'
    endif
endf
"}}}
function! DisplayManpage() "{{{
" Display man page for the file. The functions uses manpageview plugin.
    let filename = expand("%")
    let short_filename = expand("%:r")
    let filetype = &filetype
    call manpageview#ManPageView(0,0,filename)
    if v:errmsg == "no manpage exists"
        call manpageview#ManPageView(0,0,short_filename)
        if v:errmsg == "no manpage exists"
            call manpageview#ManPageView(0,0,filetype)
        endif
    endif
endf
"}}}
function! CopyAll() "{{{
    " mark whole
    exec 'normal ggVG'
    " copy whole
    exec 'normal "+y'
endf
"}}}
function! MyFoldText() "{{{
    " http://vim.wikia.com/wiki/Customize_text_for_closed_folds
    let line = getline(v:foldstart)
    if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
        let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
        let linenum = v:foldstart + 1
        while linenum < v:foldend
          let line = getline( linenum )
          let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
          if comment_content != ''
            break
          endif
          let linenum = linenum + 1
        endwhile
        let sub = initial . ' ' . comment_content
    else
        let sub = line
        let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
        if startbrace == '{'
          let line = getline(v:foldend)
          let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
          if endbrace == '}'
            let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
          endif
        endif
    endif
    let n = v:foldend - v:foldstart + 1
    let info = " " . n . " lines"
    let sub = sub . "                                                                                                                  "
    let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
    let fold_w = getwinvar( 0, '&foldcolumn' )
    let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
    return sub . info
endfunction
set foldtext=MyFoldText()
"}}}
function! s:set_all(option, val, ...) abort "{{{
" How to apply a setting in all open tabs and windows?
" https://vi.stackexchange.com/questions/12061/how-to-apply-a-setting-in-all-open-tabs-and-windows
  let val = eval(a:val)

  for t in range(1, tabpagenr('$'))
    for w in range(1, tabpagewinnr(t, '$'))
      if gettabwinvar(t, w, '&buftype') !=# ''
        continue
      endif
      call settabwinvar(t, w, '&'.a:option, val)
    endfor
  endfor
endfunction
command! -complete=option -nargs=+ SetAll call s:set_all(<f-args>)
"}}}
function! DoFormatXML() range "{{{
    " Save the file type
    let l:origft = &ft

    " Clean the file type
    set ft=

    " Add fake initial tag (so we can process multiple top-level elements)
    exe ":let l:beforeFirstLine=" . a:firstline . "-1"
    if l:beforeFirstLine < 0
        let l:beforeFirstLine=0
    endif
    exe a:lastline . "put ='</PrettyXML>'"
    exe l:beforeFirstLine . "put ='<PrettyXML>'"
    exe ":let l:newLastLine=" . a:lastline . "+2"
    if l:newLastLine > line('$')
        let l:newLastLine=line('$')
    endif

    " Remove XML header
    exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"

    " Recalculate last line of the edited code
    let l:newLastLine=search('</PrettyXML>')

    " Execute external formatter
    exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"

    " Recalculate first and last lines of the edited code
    let l:newFirstLine=search('<PrettyXML>')
    let l:newLastLine=search('</PrettyXML>')

    " Get inner range
    let l:innerFirstLine=l:newFirstLine+1
    let l:innerLastLine=l:newLastLine-1

    " Remove extra unnecessary indentation
    exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"

    " Remove fake tag
    exe l:newLastLine . "d"
    exe l:newFirstLine . "d"

    " Put the cursor at the first line of the edited code
    exe ":" . l:newFirstLine

    " Restore the file type
    exe "set ft=" . l:origft
endfunction
command! -range=% FormatXML <line1>,<line2>call DoFormatXML()

nmap <silent> <leader>x :%FormatXML<CR>
vmap <silent> <leader>x :FormatXML<CR>
"}}}
function! RemoveDiacritics(...) "{{{
    if a:0 == 0
        let s:locale='pl'
    else
        let s:locale=a:1
    endif
    if s:locale == 'pl'
        %s/[ąĄćĆęĘłŁńŃóÓśŚźŹżŻ]/
            \\={'ą':'a','Ą':'A','ć':'c','Ć':'C','ę':'e','Ę':'E','ł':'l','Ł':'L','ń':'n','Ń':'N','ó':'o','Ó':'O','ś':'s','Ś':'S','ź':'z','Ź':'Z','ż':'z','Ż':'Z'}
            \[submatch(0)]/g
    endif
endfunction "}}}
function! ToggleFoldMethod() "{{{
    if (&foldmethod == "indent")
        setlocal foldmethod=manual
        echo "Foldmethod: manual"
    elseif (&foldmethod == "manual")
        setlocal foldmethod=syntax
        echo "Foldmethod: syntax"
    elseif (&foldmethod == "syntax")
        setlocal foldmethod=marker
        echo "Foldmethod: marker"
    elseif (&foldmethod == "marker")
        setlocal foldmethod=expr
        echo "Foldmethod: expr"
    elseif (&foldmethod == "expr")
        setlocal foldmethod=diff
        echo "Foldmethod: diff"
    else
        setlocal foldmethod=indent
        echo "Foldmethod: indent"
    endif
endfunction "}}}
" Toggle signcolumn. Works only on vim>=8.0 or NeoVim
function! ToggleSignColumn() "{{{
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=auto
        let b:signcolumn_on=1
    endif
endfunction
"}}}
function! ToggleNumberColumn() "{{{
    if !exists("b:numbercolumn_on") || b:numbercolumn_on
        set nonumber
        set norelativenumber
        let b:numbercolumn_on=0
    else
        set number
        set relativenumber
        let b:numbercolumn_on=1
    endif
endfunction
" Toggle line numbers
"nnoremap <leader>n :setlocal number!<cr>
nnoremap <Leader>n :call ToggleNumberColumn()<CR>

"}}}
" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
let l:file = expand('%')
if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
endif
endfunction

function! s:align() "{{{
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
"}}}

" Show syntax color highlighting groups for word under cursor
nmap <c-s-a> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
    return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
" Commands for functions {{{2
command! -nargs=0 RemoveDiacritics call RemoveDiacratics()

" Mapping for functions {{{2
nnoremap <leader>q                  :call <SID>QuickfixToggle()<cr>
"nnoremap <leader>f                  :call FoldColumnToggle()<cr>
"noremap  <silent> <F8>              :call ChangeFileencoding()<CR>
" noremap  <silent> <F1>              :call DisplayManpage()<CR>
nnoremap <silent> <Leader><Space>   :call ToggleFoldMethod()<CR>
if has('signs') && version >= 800
    nnoremap <Leader>S :call ToggleSignColumn()<CR>
endif
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
" }}}2
