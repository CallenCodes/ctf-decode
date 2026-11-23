# Experimental Dump

de-repl() {
    setopt local_options no_notify no_monitor
    local p_flag
    p_flag=$(type de | grep -oE -- "-p ['\"]?[^ '\"]+" | head -n 1 | sed -E "s/^-p ['\"]?//")
    p_flag="${1:-${p_flag:-TEMPE{}}"

    printf "Ready (Prefix: %s) — paste & Enter (Ctrl+D to exit):\n" "$p_flag"

    while IFS= read -r line; do
        [ -z "$line" ] && continue
        {
            local out key
            out=$(de "$line" 2>&1)
            key=$(printf "%s\n" "$out" | sed -nE 's/.*"([^"]+)"[[:space:]]*<== TARGET PREFIX FOUND.*/\1/p')
            
            printf "%s\n\nFound Keys:\n%s\n\n" "$out" "${key:-None}"
        } &
    done
    wait
}
