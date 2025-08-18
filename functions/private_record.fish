if test "$private_fish_autoclear" = true
    set -g private_buffer "$private_state/private_$fish_pid.log"

    function _private_record_output --on-event fish_prompt
        if test -z "$_private_recording"
            set -g _private_recording 1
            function echo --wraps=echo
                command echo $argv | tee -a $private_buffer
            end
        end
    end
end
