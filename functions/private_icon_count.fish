function private_icon_count --description "Count active private Fish sessions"
    if not set -q fish_private_icon_state
        echo 0
        return
    end
    set -l sessions_file "$fish_private_icon_state/sessions"
    if not test -f $sessions_file
        echo 0
        return
    end
    wc -l <$sessions_file | string trim
end
