" drcstubs.vim:
"  Author:  Charles E. Campbell, Jr. (Ph.D.)
"  Date:    Nov 01, 2013
"  Version: 4g	ASTRO-ONLY
"
" Usage: {{{1
"   Double-quotes automatically converted to ``...''
"   Construct expanded upon use of backquote
"   ie.  enum`   ->
"                    \begin{enumerate}
"                     \item <cursor here>
"                    \end{enumerate}
"
"   Both of these kinds of expansions are taken
"   during insert mode.
"
"   This script is designed to work with
"   .vim/indent/tex.vim  indentation-control script.
"
" Environments And Abbreviations: {{{1
"   Short Form  Long Form
"    arr`       array`
"    ctr`       center`
"    desc`      description`
"    desc*`     description*`
"    enum`      enumerate`
"    enum*`     enumerate*`
"    eps`       epsf`       (for insertion of an eps figure)
"    eqn`       equation`
"    eqn*`      equation*`
"    eqna`      eqnarray`
"    eqna*`     eqnarray*`
"    fla`       flalign`
"    fla*`      flalign*`
"    frac`
"    i`                     (creates a \item)
"    ind`       indentation`
"    item`      itemize`
"    item*`     itemize*`
"    mat`       matrix`
"    bmat`      bmatrix`
"    pmat`      pmatrix`
"    smat`      smallmatrix`
"    vmat`      vmatrix`
"    Vmat`      Vmatrix`
"    mini`      minipage`
"    sli`
"    tab`       tabular`
"    fig`       figure`
"    frac`
"    v`                    \verb``
"    verb`      verbatim`
"
" Script Style Support: {{{1
"    bf`                   \textbf{}
"    it`                   \textit{}
"    rm`                   \textrm{}
"    sc`                   \textsc{}
"    sf`                   \textsf{}
"    sl`                   \textsl{}
"    tt`                   \texttt{}
"    mtt`                  \mathtt{}
"    mrm`                  \mathrm{}
"    mbf`                  \mathbf{}
"    msf`                  \mathsf{}
"    mtt`                  \mathtt{}
"    mit`                  \mathit{}
"    mcal`                 \mathcal{}
"
"  Greek Letters: {{{1
"    Short-Form Stands-for        Short-Form Stands-for 
"    ---------- -------------     ---------- ----------
"    a`         \alpha            v          \nu 
"    b`         \beta             f          \xi 
"    g`         \gamma            p          \pi 
"    d`         \delta            vp         \varpi 
"    e`         \epsilon          r          \rho 
"    ve`        \varepsilon       vr         \varrho 
"    z`         \zeta             s          \sigma 
"    n`         \eta              v          \varsigma 
"    t`         \theta            t          \tau 
"    vt`        \vartheta         u          \upsilon 
"    io`        \iota             h          \phi 
"    k`         \kappa            vh         \varphi 
"    l`         \lambda           x          \chi 
"    m`         \mu               q          \psi 
"    w`         \omega 
"
" If none of the above abbreviations immediately precedes the backquote,
" then the backquote will be inserted as is.

" ---------------------------------------------------------------------
" Load Once: {{{1
if exists("b:loaded_drcstubs")
  finish
endif
let b:loaded_drcstubs= "v4g"

" ---------------------------------------------------------------------
" LaTeX settings: {{{1
ino <buffer> <silent> \< \verb`<`
ino <buffer> <silent> \> \verb`>`
ino <buffer> <silent> \~ \verb`~`
ino <buffer> <silent> \" "

" ---------------------------------------------------------------------
" Comment jumping:  (based on idea from Michael Geddes) {{{1
"   ]% : jump to beginning of next     comment block
"   [% : jump to ending    of previous comment block
noremap <buffer> <silent> ]% :call search('^\(\s*%.*\n\)\@<!\(\s*%\)','W')<CR>
noremap <buffer> <silent> [% :call search('\%(^\s*%.*\n\)\%(^\s*%\)\@!','bW')<CR>

" ---------------------------------------------------------------------
" Provides support for [i and [d : {{{1
setlocal include=\\\\input
setlocal define=\\(def\\\\|let\\)
setlocal et

" ---------------------------------------------------------------------
" DrCTexStubs and Quote insertion-maps: {{{1
ino <silent> <buffer> `	<Esc>:call DrCTexStubs()<CR>a
ino <silent> <buffer> " <c-r>=TexQuotes()<cr>

" ---------------------------------------------------------------------
" DrCTexStubs Function: {{{1
fun! DrCTexStubs() "{{{2
"  call Dfunc("DrCTexStubs()")
  setl fdm=manual
"  call Decho("setl fdm=manual")

  exe "norm! a \<esc>h"
  let iskkeep= &isk
  setl isk+=*
  let wrd    = expand("<cword>")
  let vekeep = &ve
  set ve=
  let fdmkeep= &fdm

  " set up init: {{{2
  let init= (col(".") >= col("$")-1)? "diwA"    : "diwi"

  " set up lblline: look for "\ref{...}" in preceding 10 lines  {{{2
  let curline = line(".")
  call SaveWinPosn()
  let lblline = search('\\ref{',"bW")
  if lblline != 0 && lblline > curline-10
   let lblline= substitute(getline("."),'^.*ref{\([-a-zA-Z:][-a-zA-Z0-9]*\)}.*$','\1','e')
   if search('\\label{'.lblline.'}','bw')
    " if \label{lblline} is already in document, then don't repeat it
    let lblline= ""
   endif
  else
   let lblline= ""
  endif
  call RestoreWinPosn()
"  call Decho("lblline<".lblline.">  wrd<".wrd.">")

  " align*`
 if     wrd =~ '\<align\*' " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{align*}\<CR>\\end{align*}\<Esc>kox\<Esc>x"
   else
    exe "sil! norm! ".init."\\begin{align*}\\label{".lblline."}\<CR>\\end{align*}\<Esc>kox\<Esc>x"
   endif

  " align`
  elseif     wrd =~ '\<align' " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{align}\<CR>\\end{align}\<Esc>kox\<Esc>x"
   else
    exe "sil! norm! ".init."\\begin{align}\\label{".lblline."}\<CR>\\end{align}\<Esc>kox\<Esc>x"
   endif

  "cases`
  elseif wrd =~ '\<cases'     " {{{2
    exe "sil! norm! ".init."\\begin{cases}\<CR>LEFT&\\text{RIGHT}\<CR>\\end{cases}\<Esc>kFLh\<Esc>"

  " cd` compact description
  elseif wrd =~ '\<cd\%[escription]\*' " {{{2
   exe "sil! norm! bcw\\begin{compactdesc*}\<CR>\\end{compactdesc*}\<Esc>ko\\item[] \<Esc>ba\<Esc>"
   ino <esc> <esc>0f]l:iun <c-v><esc><cr>a

  " cenum` : compact enumerate
  elseif wrd =~ '\<cenum\%[erate]' " {{{2
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\begin{compactenum}\<CR>\\end{compactenum}\<Esc>ko\\item \<Esc>")

  " citem`  : compact itemize
  elseif wrd =~ '\<citem\%[ize]' " {{{2
   exe "sil! norm! ".init."\\begin{compactitem}\<CR>\\end{compactitem}\<Esc>ko\\item \<Esc>"

  " multi`
  elseif wrd =~ '\<multi\%[col]' || wrd =~ '\<multc'   " {{{2
   exe "sil! norm! ".init."\\multicolumn{1}{|c|}{MultiColumn}\<Esc>2F{"

  " multl`
  elseif wrd =~ '\<multl\%[ine]' " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{multline}\<CR>\\end{multline}\<Esc>kox\<Esc>x"
   else
    exe "sil! norm! ".init."\\begin{multline}\\label{".lblline."}\<CR>\\end{multline}\<Esc>kox\<Esc>x"
   endif

  " split`
  elseif wrd =~ '\<split'   " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{equation}\\begin{split}\<CR>\\end{split}\\end{equation}\<Esc>kox\<Esc>x"
   else
    exe "sil! norm! ".init."\\begin{equation}\\label{".lblline."}\\begin{split}\<CR>\\end{split}\\end{equation}\<Esc>kox\<Esc>x"
   endif

  " arr*`
  elseif wrd =~ '\<arr\%[ay]\*' " {{{2
   exe "sil! norm! ".init."\<cr>\\left[\\begin{array*}{ccc}\<CR>\\end{array*}\\right]\<esc>0wi \<esc>YP0wDA "

  " beg*`
 elseif wrd =~ '\<beg\%[in]' " {{{2
  exe "sil! norm! ".init."\\begin{X}\<Esc>FXxi"
  ino <esc> <esc>:iun <c-v><esc><cr>Yp0fbcwend<esc>O

  " bmat`
  elseif wrd =~ '\<bmat\%[rix]' " {{{2
   exe "sil! norm! bdwi\\begin{bmatrix}\<CR>X\<CR>\\end{bmatrix}\<Esc>0o\<Esc>?X\<CR>x"

  " Bmat`
  elseif wrd =~ '\<Bmat\%[rix]' " {{{2
   exe "sil! norm! bdwi\\begin{Bmatrix}\<CR>X\<CR>\\end{Bmatrix}\<Esc>0o\<Esc>?X\<CR>x"

  " enum`

  " des*`
  elseif wrd =~ '\<des\%[cription]\*' " {{{2
   exe "sil! norm! bcw\\begin{description*}\<CR>\\end{description*}\<Esc>ko\\item[] \<Esc>ba\<Esc>"
   ino <esc> <esc>0f]l:iun <c-v><esc><cr>a

  " enum*`
  elseif wrd =~ '\<enum\%[erate]\*' " {{{2
   exe "sil! norm! ".init."\\begin{enumerate*}\<CR>\\end{enumerate*}\<Esc>ko\\item \<Esc>"
  elseif wrd =~ '\<enum\%[erate]' " {{{2
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\begin{enumerate}\<CR>\\end{enumerate}\<Esc>ko\\item \<Esc>")

  " epsf`
  elseif wrd =~ '\<epsf\>' " {{{2
   if lblline == ""
    exe "sil! norm! bcw\\begin{figure}[H]\\centering\\framebox{\\epsfbox{X.eps}}\\end{figure}\<Esc>FXcw\<Esc>"
   else
    exe "sil! norm! bcw\\begin{figure}[H]\\label{".lblline."}\\centering\\framebox{\\epsfbox{X.eps}}\\end{figure}\<Esc>FXcw\<Esc>"
   endif

  " epsp`
 elseif wrd =~ '\<epsp\>' " {{{2
  call drcstubs#DrCStubMulti("sil! norm! bcw\\parbox[c]{1.5in}{\\psfrag{&}{&}\\includegraphics[scale=.5]{&.eps}}\<Esc>",
     \ "F&:echo 'Enter fig filename'\<cr>x",
     \ "2F&:echo 'Enter Equation Name'\<cr>x",
     \ "f&:echo 'Enter Equation'\<cr>x",
     \ "/}}\<cr>ll")

  elseif wrd =~ '\<eps\>' " {{{2
   call drcstubs#DrCStubMulti("sil! norm! bcw\\parbox[c]{1.5in}{\\includegraphics[scale=.5]{X.eps}}\<Esc>",
	  \ 'FXx'."\<Esc>:echo 'Enter fig filename'\<cr>",
      \ "/}}\<cr>ll")

  " eqna*`
  elseif wrd =~ '\<eqna\%[rray]\*' || wrd =~ '\<eqna\*' " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{eqnarray*}\<CR>\\end{eqnarray*}\<Esc>ko & = &  \\\\\<Esc>0f&hh"
   else
    exe "sil! norm! ".init."\\begin{eqnarray*}\\label{".lblline."}\<CR>\\end{eqnarray*}\<Esc>ko & = &  \\\\\<Esc>0f&hh"
   endif
   ino <esc> <esc>02f&l:iun <c-v><esc><cr>a

  " eqna`
  elseif wrd =~ '\<eqna\%[rray]' " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{eqnarray}\<CR>\\end{eqnarray}\<Esc>ko & = &  \\\\\<Esc>0f&hh"
   else
    exe "sil! norm! ".init."\\begin{eqnarray}\\label{".lblline."}\<CR>\\end{eqnarray}\<Esc>ko & = &  \\\\\<Esc>0f&hh"
   endif
   ino <esc> <esc>02f&l:iun <c-v><esc><cr>a

  " fla*`
  elseif wrd =~ '\<fla\%[lign]\*' " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{flalign*}\<CR>\\end{flalign*}\<Esc>kox\<Esc>x"
   else
    exe "sil! norm! ".init."\\begin{flalign*}\\label{".lblline."}\<CR>\\end{flalign*}\<Esc>kox\<Esc>x"
   endif

  " frac`
  elseif wrd =~ '\<frac'   " {{{2
   exe "sil! norm! ".init."\\frac{}{}\<Esc>2hi"
   ino <esc> <esc>02f{:iun <c-v><esc><cr>a

  " ind` indentation`
  elseif wrd =~ '\<ind\%[entation]' " {{{2
   exe "sil! norm! ".init."\\begin{indentation}{\\logicindent}{0em} % {left-indent}{right-indent}\<CR>\\end{indentation}\<Esc>kYp0wDA  \<Esc>"

  elseif wrd =~ '\<item\%[ize]\*' " {{{2
   exe "sil! norm! ".init."\\begin{itemize*}\<CR>\\end{itemize*}\<Esc>ko\\item \<Esc>"

   " item` item*`
  elseif wrd =~ '\<item\%[ize]\*' " {{{2
   exe "sil! norm! ".init."\\begin{itemize*}\<CR>\\end{itemize*}\<Esc>ko\\item \<Esc>"
  elseif wrd =~ '\<item\%[ize]' " {{{2
   exe "sil! norm! ".init."\\begin{itemize}\<CR>\\end{itemize}\<Esc>ko\\item \<Esc>"

  " mini`
  elseif wrd =~ '\<mini\%[page]' " {{{2
   exe "sil! norm! bdwi\\begin{minipage}[H]{Xin}\<CR>\\end{minipage}\<Esc>?X\<cr>xi"
   ino <esc> <esc>:iun <c-v><esc><cr>o

  " pmat`
  elseif wrd =~ '\<pmat\%[rix]' " {{{2
   exe "sil! norm! bdwi\\begin{pmatrix}\<CR>X\<CR>\\end{pmatrix}\<Esc>0o\<Esc>?X\<CR>x"

  " ptab`
  elseif wrd =~ '\<ptab\%[ular]' " {{{2
   if lblline == ""
	exe "sil! norm! bcw\\begin{center}\\begin{tabular}{X}\<CR>\\end{tabular}\\end{center}\<CR>\<esc>"
   else
	exe "sil! norm! bcw\\begin{center}\\begin{tabular}{X}\\label{".lblline."}\<CR>\\end{tabular}\\end{center}\<CR>\<esc>"
   endif
   exe "sil! norm! kk0fXxi"
   ino <esc> <esc>:iun <c-v><esc><cr>o

  " smat`
  elseif wrd =~ '\<smat' || wrd =~ '\<smallmatrix'  " {{{2
   exe "sil! norm! bdwa\\left[\\begin{smallmatrix}X\\end{smallmatrix}\\right]\<Esc>?X\<CR>xh"

  " verb`
  elseif wrd =~ '\<verb\%[atim]'   " {{{2
   exe "sil! norm! bdwi\\begin{verbatim}\<CR>\<c-u>\\end{verbatim}\<Esc>kA\<cr>\<c-u>"

  " vmat`
  elseif wrd =~ '\<vmat\%[rix]' " {{{2
   exe "sil! norm! bdwi\\begin{vmatrix}\<CR>X\<CR>\\end{vmatrix}\<Esc>0o\<Esc>?X\<CR>x"

  " Vmat`
  elseif wrd =~ '\<Vmat\%[rix]' " {{{2
   exe "sil! norm! bdwi\\begin{Vmatrix}\<CR>X\<CR>\\end{Vmatrix}\<Esc>0o\<Esc>?X\<CR>x"

  " arr`
  elseif wrd =~ '\<arr\%[ay]' " {{{2
   exe "sil! norm! ".init."\<cr>\\left[\\begin{array}{ccc}\<CR>\\end{array}\\right]\<esc>0wi \<esc>YP0wDA "

  " cen`
  elseif wrd =~ '\<cen\%[ter]' || wrd =~ '\<ctr'   " {{{2
   exe "sil! norm! ".init."\\begin{center}\<CR>\\end{center}\<Esc>ko\<Esc>"

  " des`
  elseif wrd =~ '\<des\%[cription]' " {{{2
   exe "sil! norm! bcw\\begin{description}\<CR>\\end{description}\<Esc>ko\\item[] \<Esc>ba\<Esc>"
   ino <esc> <esc>0f]l:iun <c-v><esc><cr>a

  " fig`
  elseif wrd =~ '\<fig\%[ure]' " {{{2
   if lblline == ""
    exe "sil! norm! bcw\\begin{figure}[H]\\centering\<CR> \\framebox{X}\<CR> \\caption{CAPTION HERE}\<CR> \\end{figure}\<Esc>0kkfXcw\<Esc>"
   else
    exe "sil! norm! bcw\\begin{figure}[H]\\label{".lblline."}\\centering\<CR> \\framebox{X}\<CR> \\caption{CAPTION HERE}\<CR> \\end{figure}\<Esc>0kkfXcw\<Esc>"
   endif

  " fla`
  elseif wrd =~ '\<fla\%[lign]' " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{flalign}\<CR>\\end{flalign}\<Esc>kox\<Esc>x"
   else
    exe "sil! norm! ".init."\\begin{flalign}\\label{".lblline."}\<CR>\\end{flalign}\<Esc>kox\<Esc>x"
   endif

  " gat`
  elseif wrd =~ '\<gat\%[her]' " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{gather}\<CR>\\end{gather}\<Esc>kox\<Esc>x"
   else
    exe "sil! norm! ".init."\\begin{gather}\\label{".lblline."}\<CR>\\end{gather}\<Esc>kox\<Esc>x"
   endif

  " ind`
  elseif wrd =~ '\<ind\%[ent]'   " {{{2
   exe "sil! norm! ".init."\\begin{indentation}{\\logicindent}{0em}\<CR>\\end{indentation}\<Esc>ko\<Esc>x"

  " lst`
  elseif wrd =~ '\<lst\%[listing]'	" {{{2
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\begin{lstlisting}\<CR>\\end{lstlisting}\<Esc>ko \<Esc>x")

  " mat`
  elseif wrd =~ '\<mat\%[rix]' " {{{2
   exe "sil! norm! bdwi\\left[\\begin{matrix}\<CR>X\<CR>\\end{matrix}\\right]\<Esc>0o\<Esc>?X\<CR>x"

   " nst[tabbing]`
  elseif wrd =~ '\<nst\%[abbing]' " {{{2
   exe "sil! norm! bcw\\begin{nstabbing}\<CR>X\<CR>\\end{nstabbing}\<esc>?X\<CR>x"

  " sli`
  elseif wrd =~ '\<sli\%[de]' " {{{2
   exe "sil! norm! bcw\\begin{slide}{X} % \{\{\{2 \<CR>\\end{slide}\<esc>k0fXxi"
   ino <esc> <esc>:iun <c-v><esc><cr>o

  " tabb[ing]`
  elseif wrd =~ '\<tabb\%[ing]' " {{{2
   exe "sil! norm! bcw\\begin{tabbing}\<CR>X\<CR>\\end{tabbing}\<esc>?X\<CR>x"

  " tab`
  elseif wrd =~ '\<tab\%[ular]' " {{{2
   exe "sil! norm! bdw\<Esc>"
   if lblline == ""
    exe "sil! norm! o\\begin{table}[H]\<CR>\\begin{center}\\begin{tabular}{||l|l|l||}\<CR>\\hline\\hline\<CR>\\multicolumn{1}{||c|}{Column 1} &\<CR>\\multicolumn{1}{c|}{Column 2}   &\<CR>\\multicolumn{1}{c||}{Column 3}  \\\\\<CR>\\hline\<CR>  ...&...&...\\\\\<CR>\<BS>\<BS>\\hline\\hline\<CR>\<BS>\\end{tabular}\\end{center}\<CR>\\caption{Table Name}\<CR>\\end{table}\<CR>\<ESC>"
   else
    exe "sil! norm! o\\begin{table}[H]\\label{".lblline."}\<CR>\\begin{center}\\begin{tabular}{||l|l|l||}\<CR>\\hline\\hline\<CR>\\multicolumn{1}{||c|}{Column 1} &\<CR>\\multicolumn{1}{c|}{Column 2}   &\<CR>\\multicolumn{1}{c||}{Column 3}  \\\\\<CR>\\hline\<CR>  ...&...&...\\\\\<CR>\<BS>\<BS>\\hline\\hline\<CR>\<BS>\\end{tabular}\\end{center}\<CR>\\caption{Table Name}\<CR>\\end{table}\<CR>\<ESC>"
   endif
   exe "sil! norm! ?begin{tabular}?\<CR>fl;h"

  " eq*`  eqn*`
  elseif wrd =~ 'eq\%[uation]\*' || wrd =~ '\<eq\*' || wrd =~ '\<eqn\*' " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{equation*}\<CR>\\end{equation*}\<Esc>kox\<Esc>x"
   else
    exe "sil! norm! ".init."\\begin{equation*}\\label{".lblline."}\<CR>\\end{equation*}\<Esc>kox\<Esc>x"
   endif

   " eq`  eqn`
  elseif wrd =~ 'eq\%[uation]' || wrd =~ '\<eqn'   " {{{2
   if lblline == ""
    exe "sil! norm! ".init."\\begin{equation}\<CR>\\end{equation}\<Esc>kox\<Esc>x"
   else
    exe "sil! norm! ".init."\\begin{equation}\\label{".lblline."}\<CR>\\end{equation}\<Esc>kox\<Esc>x"
   endif

  " i`
  elseif wrd =~ '\<i\>'   " {{{2
   if v:version >= 700
   	let swp = SaveWinPosn()
	let bgn = 1
	let end = 1
	while bgn <= end && bgn > 0 && end > 0
	 let end= search('\\end\s*{\s*\%(itemize\|description\|enumerate\)\s*}','bnW')
	 let bgn= search('\\begin\s*{\s*\%(itemize\|description\|enumerate\)\s*}','bW')
	endwhile
	call RestoreWinPosn(swp)
	if getline(bgn) =~ "description"
     exe "sil! norm! ".init."\\item[] \<Esc>hha"
     ino <esc> <esc>0f]l:iun <c-v><esc><cr>a
	else
     exe "sil! norm! ".init."\\item "
	endif
   else
    exe "sil! norm! ".init."\\item "
   endif

  " gc` : green comment
  elseif wrd =~ '\<gc\>'   " {{{2
   call drcstubs#DrCStubMulti('sil! norm! bcw\textcolor{green}{\textbf{&}}',"F&:echo 'Enter comment'\<cr>x","/}}\<cr>ll")

  " g` : gray75 text
  elseif wrd =~ '\<Gc'     " {{{2
   call drcstubs#DrCStubMulti('sil! norm! xi\textcolor{gray75}{\textsf{\footnotesize &}}',"F&:echo 'Enter text'\<cr>x","/}}\<cr>ll")

  " v`
  elseif wrd =~ '\<v'      " {{{2
   call drcstubs#DrCStubMulti('sil! norm! xi\verb`&`',"F&:echo 'Enter text'\<cr>x","/`\<cr>l")

  " V`
  elseif wrd =~ '\<V'      " {{{2
   call drcstubs#DrCStubMulti('sil! norm! xi\Verbatim`&`',"F&:echo 'Enter text'\<cr>x","/`\<cr>l")

  " LaTeX script support   " {{{2
  " bf`
  elseif wrd =~ '\<bf'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\textbf{&}\<esc>","F&:echo 'Enter bold text'\<cr>x","/}\<cr>l")
   " it`
  elseif wrd =~ '\<it'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\textit{&}\<esc>","F&:echo 'Enter italic text'\<cr>x","/}\<cr>l")
   " rm`
  elseif wrd =~ '\<rm'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\textrm{&}\<esc>","F&:echo 'Enter roman text'\<cr>x","/}\<cr>l")
   " sc`
  elseif wrd =~ '\<sc'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\textsc{&}\<esc>","F&:echo 'Enter slanted capital text'\<cr>x","/}\<cr>l")
   " sf`
  elseif wrd =~ '\<sf'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\textsf{&}\<esc>","F&:echo 'Enter sans-serif text'\<cr>x","/}\<cr>l")
   " sl`
  elseif wrd =~ '\<sl'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\textsl{&}\<esc>","F&:echo 'Enter slanted text'\<cr>x","/}\<cr>l")
   " tt`
  elseif wrd =~ '\<tt'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\texttt{&}\<esc>","F&:echo 'Enter typewriter text'\<cr>x","/}\<cr>l")
   " mcal`
  elseif wrd =~ '\<mcal'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\mathcal{&}\<esc>","F&:echo 'Enter calligraphic text'\<cr>x","/}\<cr>l")
   " mbf`
  elseif wrd =~ '\<mbf'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\mathbf{&}\<esc>","F&:echo 'Enter math-bold text'\<cr>x","/}\<cr>l")
   " mit`
  elseif wrd =~ '\<mit'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\mathit{&}\<esc>","F&:echo 'Enter math-italic text'\<cr>x","/}\<cr>l")
   " mrm`
  elseif wrd =~ '\<mrm'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\mathbf{&}\<esc>","F&:echo 'Enter math-roman text'\<cr>x","/}\<cr>l")
   " msf`
  elseif wrd =~ '\<msf'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\mathsf{&}\<esc>","F&:echo 'Enter math-slanted text'\<cr>x","/}\<cr>l")
   " mtt`
  elseif wrd =~ '\<mtt'
   call drcstubs#DrCStubMulti("sil! norm! ".init."\\mathtt{&}\<esc>","F&:echo 'Enter math-typewriter text'\<cr>x","/}\<cr>l")

  " Lower case Greek alphabet   " {{{2
   " a`
  elseif wrd =~ '\<a\>'
   exe "sil! norm! r\\aalpha\<Esc>a"
   " b`
  elseif wrd =~ '\<b\>'
   exe "sil! norm! r\\abeta\<Esc>a"
   " g`
  elseif wrd =~ '\<g\>'
   exe "sil! norm! r\\agamma\<Esc>a"
   " d`
  elseif wrd =~ '\<d\>'
   exe "sil! norm! r\\adelta\<Esc>a"
   " e`
  elseif wrd =~ '\<e\>'
   exe "sil! norm! r\\aepsilon\<Esc>a"
   " ve`
  elseif wrd =~ '\<ve\>'
   exe "sil! norm! ".init."\\varepsilon"
   " z`
  elseif wrd =~ '\<z\>'
   exe "sil! norm! r\\azeta\<Esc>a"
   " n`
  elseif wrd =~ '\<n\>'
   exe "sil! norm! r\\aeta\<Esc>a"
   " t`
  elseif wrd =~ '\<t\>'
   exe "sil! norm! r\\atheta\<Esc>a"
   " vt`
  elseif wrd =~ '\<vt\>'
   exe "sil! norm! ".init."\\vartheta"
   " io`
  elseif wrd =~ '\<io\>'
   exe "sil! norm! ".init."\\iota"
   " k`
  elseif wrd =~ '\<k\>'
   exe "sil! norm! r\\akappa\<Esc>a"
   " l`
  elseif wrd =~ '\<l\>'
   exe "sil! norm! r\\alambda\<Esc>a"
   " m`
  elseif wrd =~ '\<m\>'
   exe "sil! norm! r\\amu\<Esc>a"
   " vv`
  elseif wrd =~ '\<vv\>'
   exe "sil! norm! r\\anu\<Esc>a"
   " p`
  elseif wrd =~ '\<p\>'
   exe "sil! norm! r\\api\<Esc>a"
   " vp`
  elseif wrd =~ '\<vp\>'
   exe "sil! norm! ".init."\\varpi"
   " r`
  elseif wrd =~ '\<r\>'
   exe "sil! norm! r\\arho\<Esc>a"
   " vr`
  elseif wrd =~ '\<vr\>'
   exe "sil! norm! ".init."\\varrho"
   " vt`
  elseif wrd =~ '\<vt\>'
   exe "sil! norm! ".init."\\vartheta"
   " s`
  elseif wrd =~ '\<s\>'
   exe "sil! norm! r\\asigma\<Esc>a"
   " vs`
  elseif wrd =~ '\<vs\>'
   exe "sil! norm! r\\avarsigma\<Esc>a"
   " tau`
  elseif wrd =~ '\<tau\>'
   exe "sil! norm! r\\atau\<Esc>a"
   " u`
  elseif wrd =~ '\<u\>'
   exe "sil! norm! r\\aupsilon\<Esc>a"
   " h`
  elseif wrd =~ '\<h\>'
   exe "sil! norm! r\\aphi\<Esc>a"
   " vh`
  elseif wrd =~ '\<vh\>'
   exe "sil! norm! ".init."\\varphi"
   " x`
  elseif wrd =~ '\<x\>'
   exe "sil! norm! r\\achi\<Esc>a"
   " q`
  elseif wrd =~ '\<q\>'
   exe "sil! norm! r\\apsi\<Esc>a"
   " w`
  elseif wrd =~ '\<w\>'
   exe "sil! norm! r\\aomega\<Esc>a"

  else
   exe "sil! norm! a`\<Esc>"
  endif

  let &ve  = vekeep
  let &isk = iskkeep
  let &fdm = fdmkeep
"  call Decho("restored fdm=".fdmkeep)
"  call Dret("DrCTexStubs")
endfun

" ---------------------------------------------------------------------
" TexQuotes: converts a '"' into `` or '' in LaTeX. {{{1
"            Supports an imap
fun! TexQuotes()
  let line   = getline(".")
  let curpos = col(".")-1
  let insert = "''"
  let left   = strpart(line, curpos-1, 1)
  let tzid   = synIDtrans(hlID("texZone"))
  let curcol = col(".") - 1

  if tzid == synIDtrans(synID(line("."),curcol,1))
   let insert= '"'
  elseif left == "\\"
    exe "norm! hr\"i\"\<Esc>l"
    let insert = ''
  elseif left == ' ' || left == '	' || left == ''
    let insert = '``'
    endif
  return insert
endfun

" ---------------------------------------------------------------------
"  vim:fdm=marker
