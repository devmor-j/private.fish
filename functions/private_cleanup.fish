function _private_cleanup --on-event fish_exit
    # Remove PID from sessions
    if test -f $private_state/sessions
        grep -v "^$fish_pid\$" $private_state/sessions >$private_state/sessions.tmp
        mv $private_state/sessions.tmp $private_state/sessions
    end

    # Clear only lines written in private mode
    if test $private_fish_autoclear = true
        if test -f $private_buffer
            set -l lines (wc -l < $private_buffer)
            for i in (seq $lines)
                echo -ne "\033[1A\033[2K"
            end
            rm $private_buffer
        end
    end
end
