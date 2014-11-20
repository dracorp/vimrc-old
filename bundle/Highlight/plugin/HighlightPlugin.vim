" HighlightPlugin.vim
"   Author: Charles E. Campbell, Jr.
"   Date:   Nov 19, 2010
"   Version: 1d	NOT RELEASED
" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp || exists("g:loaded_HighlightPlugin")
 finish
endif
let g:loaded_HighlightPlugin = "v1d"
let s:keepcpo                = &cpo
set cpo&vim

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com! -nargs=* -bar		HLcolor			call Highlight#Color(<f-args>)
com! -count=1 -nargs=*	HLsrch			call Highlight#Srch(<count>,<q-args>)
com! -nargs=? -bar		HLclear			call Highlight#Clear(<f-args>)
com! -range	  -nargs=?  HL				call Highlight#Srch(<q-args>,'\%'.line("'<").'l\%'.col("'<").'c\_.*\%'.line("'>").'l\%'.((col("'>") < col("$"))? col("'>")+1 : col("'>")).'c')
com! -range=1 -nargs=?  HLl				<line1>,<line2>call Highlight#Srch(<q-args>,'^\%'.line(".").'l.*$')
com! -range=1 -nargs=?  HLw				<line1>,<line2>call Highlight#Srch(<q-args>,expand("<cword>"))
com! -nargs=? -bar		HLC				call Highlight#Clear(<f-args>)
com! -range=1 -nargs=?  HLW				call Highlight#Srch(<q-args>,expand("<cword>"))
com! -range=1 -nargs=?  HLL				.,.call Highlight#Srch(<q-args>,'^\%'.line(".").'l.*$')
vmap <silent>           <Leader>HL 		:<c-u>call Highlight#Srch(v:count,'\%'.line("'<").'l\%'.col("'<").'c\_.*\%'.line("'>").'l\%'.((col("'>") < col("$"))? col("'>")+1 : col("'>")).'c')<cr>
nmap <silent>			<Leader>HLl		:<c-u>call Highlight#Srch(v:count,'^\%'.line(".").'l.*$')<cr>
nmap <silent>			<Leader>HLw		:<c-u>call Highlight#Srch(v:count,expand("<cword>"))<cr>

" ---------------------------------------------------------------------
" DrChip Menu Support: {{{1
if has("gui_running") && has("menu") && &go =~ 'm'
 if !exists("g:DrChipTopLvlMenu")
  let g:DrChipTopLvlMenu= "DrChip."
 endif
 exe 'menu '.g:DrChipTopLvlMenu.'Highlight.Start	:call Highlight#Menu()<cr>'
endif

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=4 fdm=marker
