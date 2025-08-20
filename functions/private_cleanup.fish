function _private_cleanup --on-event fish_exit
    # Remove PID from this terminal's sessions file
    if test -n "$private_sessions_file" -a -f $private_sessions_file
        grep -v "^$fish_pid\$" $private_sessions_file >$private_sessions_file.tmp
        mv $private_sessions_file.tmp $private_sessions_file

        # If now empty, remove the file to avoid clutter
        if test ! -s $private_sessions_file
            rm -f $private_sessions_file
        end
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
