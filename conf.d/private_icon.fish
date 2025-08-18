# fish-private-icon: setup defaults and initialize

# --- Defaults (user can override in config.fish) ---
if not set -q fish_private_icon_symbol
    set -U fish_private_icon_symbol "👻"
end

if not set -q fish_private_icon_show_count
    set -U fish_private_icon_show_count true
end

# --- Pick a state directory (single path, not a list) ---
if set -q XDG_RUNTIME_DIR
    set -g fish_private_icon_state "$XDG_RUNTIME_DIR/fish-private-icon"
else if set -q XDG_STATE_HOME
    set -g fish_private_icon_state "$XDG_STATE_HOME/fish-private-icon"
else
    set -g fish_private_icon_state "$HOME/.local/state/fish-private-icon"
end

mkdir -p $fish_private_icon_state

# --- Detect private session ---
if status --is-interactive
    if set -q fish_private_mode
        set -g fish_private_icon_active 1

        # Register this session PID
        echo $fish_pid >>$fish_private_icon_state/sessions

        # Clean up on exit
        function _fish_private_icon_cleanup --on-event fish_exit
            if test -f $fish_private_icon_state/sessions
                grep -v "^$fish_pid\$" $fish_private_icon_state/sessions >$fish_private_icon_state/sessions.tmp
                mv $fish_private_icon_state/sessions.tmp $fish_private_icon_state/sessions
            end
        end
    end
end

# --- Prompt auto-hook ---
function _fish_private_icon_wrap_prompt --on-event fish_prompt
    if functions -q fish_prompt; and not functions -q _fish_private_icon_original_prompt
        functions --copy fish_prompt _fish_private_icon_original_prompt
        function fish_prompt
            private_icon_prompt
            _fish_private_icon_original_prompt
        end
    end
end
