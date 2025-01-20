function cdb --description "Change to bookmarked directory"
    if test (count $argv) -gt 1
        printf "%s\n" (_ "Too many args") >&2
        return 1
    else if test (count $argv) -eq 0
        cat ~/.cdbookmarks 2>/dev/null
        return $status
    end

    set -l newdir (grep -E -w "^$argv[1]" ~/.cdbookmarks | awk '{print $2}')
    if test -n "$newdir"
        cd $newdir
        return $status
    else
        echo "Directory $argv[1] not found"
        return 1
    end
end
