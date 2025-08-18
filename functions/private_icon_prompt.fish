function private_icon_prompt --description "Show private mode indicator for prompt"
    if not set -q fish_private_icon_active
        return
    end

    set -l icon $fish_private_icon_symbol

    if test "$fish_private_icon_show_count" = true
        set -l count (private_icon_count)
        if test $count -gt 1
            set icon "$icon$count"
        end
    end

    echo -n $icon' '
end
