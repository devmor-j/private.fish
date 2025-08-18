function private_count --description "Count active private Fish sessions and clean dead PIDs"
    if not set -q private_state
        echo 0
        return
    end

    set -l sessions_file "$private_state/sessions"
    if not test -f $sessions_file
        echo 0
        return
    end

    set -l active_pids
    for pid in (cat $sessions_file)
        if kill -0 $pid 2>/dev/null
            set active_pids $active_pids $pid
        end
    end

    # Rewrite sessions file with only active PIDs
    printf "%s\n" $active_pids >$sessions_file

    echo (count $active_pids)
end
