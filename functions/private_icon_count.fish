function private_icon_count --description "Count active private Fish sessions"
    # Count processes with FISH_PRIVATE exported
    set -l count (ps -o pid= -o command= -C fish ^/dev/null | grep -c "FISH_PRIVATE")
    echo $count
end
