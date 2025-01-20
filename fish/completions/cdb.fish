# Completions for cdb
complete -c cdb -x -d "Bookmark" -a "(cat ~/.cdbookmarks 2>/dev/null | awk '{print \$1}')"
