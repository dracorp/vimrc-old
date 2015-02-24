# bash completion for <+#COMMAND#;R++++++++++++++++++++++++>-*- shell-script -*-

_<+#COMMAND#+>(){
    COMPREPLY=()
    local cur opts
    _get_comp_words_by_ref cur
    local opts=$(_parse_help $1 -h)
    COMPREPLY=( $( compgen -W "$opts" -- "$cur" ) )
} &&
complete -F _<+#COMMAND#+> <+#COMMAND#+>
