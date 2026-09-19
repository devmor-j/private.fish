# Defaults
# set -g, not -U: the plugin must not write universals into the user's
# config, or uninstalling it would leave residue behind
if not set -q private_symbol
    set -g private_symbol "👻"
end
if not set -q root_symbol
    set -g root_symbol "🔥"
end
if not set -q private_show_count
    set -g private_show_count true
end
if not set -q private_fish_autoclear
    set -g private_fish_autoclear false
end

# State directory
if set -q XDG_RUNTIME_DIR
    set -g private_state "$XDG_RUNTIME_DIR/private.fish"
else if set -q XDG_STATE_HOME
    set -g private_state "$XDG_STATE_HOME/private.fish"
else
    set -g private_state "$HOME/.local/state/private.fish"
end
mkdir -p $private_state

# Compute a per-terminal/session key
function __private_tty_id --description "Stable id for current terminal session"
    # Prefer terminal-provided session IDs when available (macOS Terminal/iTerm)
    if set -q TERM_SESSION_ID
        echo $TERM_SESSION_ID
        return
    end
    if set -q ITERM_SESSION_ID
        echo $ITERM_SESSION_ID
        return
    end

    # Fallback to controlling TTY (e.g., /dev/pts/3 or ttys001)
    set -l t (command tty 2>/dev/null)
    if test $status -eq 0 -a -n "$t"
        # Strip directory to make a filename-friendly id
        string replace -r '.*/' '' -- $t
        return
    end

    echo unknown
end

# Per-terminal sessions file (e.g., $private_state/sessions.pts3)
set -g private_tty_id (__private_tty_id)
set -g private_sessions_file "$private_state/sessions.$private_tty_id"

# Detect private session (mark active and record session)
if status --is-interactive
    if set -q fish_private_mode
        set -g private_active 1
        # Append this PID once to the per-terminal file
        if test -f $private_sessions_file
            if not grep -q "^$fish_pid\$" $private_sessions_file
                echo $fish_pid >>$private_sessions_file
            end
        else
            echo $fish_pid >$private_sessions_file
        end
    end
end

# Event handlers only register when their definition runs, and function
# files are autoloaded on first call - which never happens for handlers
# waiting on an event. Source them explicitly so they register at startup.
function __private_load_handlers
    for dir in $fish_function_path
        for name in private_cleanup private_record
            if test -f $dir/$name.fish
                source $dir/$name.fish
            end
        end
    end
end
__private_load_handlers

# Delay wrapping prompt until fish_prompt event, ensures functions are loaded
function __private_init --on-event fish_prompt
    private_wrap_prompt
end
