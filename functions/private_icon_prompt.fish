function private_icon_prompt --description "Show private and root mode indicator for prompt"
    set -l icon ''

    if test (id -u) -eq 0
        set icon "$root_symbol$icon"
    end

    if set -q private_active
        set icon "$icon$private_symbol"

        if test "$private_show_count" = true
            set -l count (private_count)
            if test $count -gt 1
                set icon "$icon$count"
            end
        end
    end

    echo -n "$icon "
end
