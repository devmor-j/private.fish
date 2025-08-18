function private_wrap_prompt
    if functions -q fish_prompt; and not functions -q _private_original_prompt
        functions --copy fish_prompt _private_original_prompt
        function fish_prompt
            private_icon_prompt
            _private_original_prompt
        end
    end
end
