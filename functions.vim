function! UsunDiakrytyki()
    %s/[ąĄćĆęĘłŁńŃóÓśŚźŹżŻ]/
        \\={'ą':'a','Ą':'A','ć':'c','Ć':'C','ę':'e','Ę':'E','ł':'l','Ł':'L','ń':'n','Ń':'N','ó':'o','Ó':'O','ś':'s','Ś':'S','ź':'z','Ź':'Z','ż':'z','Ż':'Z'}
        \[submatch(0)]/g
endfunction
command! -nargs=0 UsunDiakrytyki call UsunDiakrytyki()
