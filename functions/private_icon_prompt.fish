function private_icon_prompt --description "Show private mode indicator for prompt"
    if not set -q private_active
        return
    end

    set -l icon $private_symbol

    if test "$private_show_count" = true
        set -l count (private_count)
        if test $count -gt 1
            set icon "$icon$count"
        end
    end

    echo -n $icon' '
end
