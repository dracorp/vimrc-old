function! GetPerlFold()
  if getline(v:lnum) =~ '^\s*sub\s'
    return ">1"
  elseif getline(v:lnum) =~ '\}\s*$'
    let my_perlnum = v:lnum
    let my_perlmax = line("$")
    while (1)
      let my_perlnum = my_perlnum + 1
      if my_perlnum > my_perlmax
        return "<1"
      endif
      let my_perldata = getline(my_perlnum)
      if my_perldata =~ '^\s*\(\#.*\)\?$'
        " do nothing
      elseif my_perldata =~ '^\s*sub\s'
        return "<1"
      else
        return "="
      endif
    endwhile
  else
    return "="
  endif
endfunction

"set foldexpr=GetPerlFold()

set number
"set foldmethod = marker
"set foldmarker = {,}
let perl_fold = 1
let perl_fold_blocks = 1
let perl_include_pod = 1                        " include pod.vim syntax file with perl.vim"
let perl_sync_dist = 250                        " use more context for highlighting"
let perl_extended_vars = 1                      " highlight complex expressions such as @{[$x, $y]}"
let perl_want_scope_in_variables = 1


fu! MyFoldSettings()
  set foldmethod=expr
  set foldexpression=MyFoldLevel(v:lnum)
  set foldenable
  set foldminlines=1
endf

fu! MyFoldLevel(lev)
    let mytext = getline(a:lev)
    let result="="
    if mytext =~ '^=item'
        let result=">3"
    elsei mytext =~ '^=back'
        let result="<2"
    elsei mytext =~ '^=over'
        let result=">2"
    elsei mytext =~ '^=cut'
        let result="<1"
    elsei mytext =~ '^=\w\+'
        let result='>1'
    en
    return result
endf

augroup MyFoldSettings_AutoCommands
   au!
   au BufReadPost {*.pl,*.pod,*.pm} MyFoldSettings()
augroup END
