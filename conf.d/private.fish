# Defaults
if not set -q private_symbol
    set -U private_symbol "👻"
end
if not set -q private_show_count
    set -U private_show_count true
end
if not set -q private_fish_autoclear
    set -U private_fish_autoclear false
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

# Detect private session (mark active and record session)
if status --is-interactive
    if set -q fish_private_mode
        set -g private_active 1
        echo $fish_pid >>$private_state/sessions
    end
end

# Delay wrapping prompt until fish_prompt event, ensures functions are loaded
function __private_init --on-event fish_prompt
    if set -q fish_private_mode
        private_wrap_prompt
    end
end
