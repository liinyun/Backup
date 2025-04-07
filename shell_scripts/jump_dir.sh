#!/bin/bash

selected_dir=$(find . -type d | fzf)
if [[ -n "$selected_dir" ]]; then
    cd "$selected_dir" || { echo "Failed to change directory."; exit 1; }
    echo "Jumped to directory: $selected_dir"
else
    echo "No directory selected."
fi
