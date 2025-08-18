# fish-private-icon: setup defaults and initialize

# --- Defaults (user can override in config.fish) ---
if not set -q fish_private_icon_symbol
    set -U fish_private_icon_symbol "👻"
end

if not set -q fish_private_icon_show_count
    set -U fish_private_icon_show_count true
end

# --- Detect private session ---
# Convention: users launch fish with `fish --private` or export FISH_PRIVATE=1
if status --is-interactive
    if set -q FISH_PRIVATE
        set -g fish_private_icon_active 1
    end
end

# --- Prompt auto-hook ---
# Only wrap once to avoid recursion
if functions -q fish_prompt; and not functions -q _fish_private_icon_original_prompt
    functions --copy fish_prompt _fish_private_icon_original_prompt
    function fish_prompt
        private_icon_prompt
        _fish_private_icon_original_prompt
    end
end
