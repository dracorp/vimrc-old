# bash completion for <+#COMMAND#;R++++++++++++++++++++++++>-*- shell-script -*-

_<+#COMMAND#+>(){
    COMPREPLY=()
    local cur=${COMP_WORDS[COMP_CWORD]}         # current word
    local opts="`$1 2>&1 |tr ' |' '\n\n' | sed -ne 's/[^-]*\(-\{1,2\}[a-z]\{1,\}\).*/\1/p' | sort -u`"
} &&
complete -F _<+#COMMAND#+> <+#COMMAND#+>

# vi: ft=sh
