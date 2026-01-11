#!/bin/bash

FOLLOW_SYMLINKS=0

if [ "$1" = "--follow-symlinks" ]; then
    FOLLOW_SYMLINKS=1
    DIR="$2"
else
    DIR="$1"
fi

if [ -z "$DIR" ]; then
    echo "Usage: $0 [--follow-symlinks] <directory>"
    exit 1
fi

if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory"
    exit 1
fi

 scan_dir() {
    local CURRENT_DIR="$1"

    for ITEM in "$CURRENT_DIR"/*; do
        [ -e "$ITEM" ] || [ -L "$ITEM" ] || continue

        if [ -L "$ITEM" ] && [ ! -e "$ITEM" ]; then
            TARGET=$(readlink "$ITEM")
            echo "Broken link: $ITEM -> $TARGET"

        elif [ -d "$ITEM" ] && [ ! -L "$ITEM" ]; then
            scan_dir "$ITEM"

        elif [ -d "$ITEM" ] && [ -L "$ITEM" ] && [ "$FOLLOW_SYMLINKS" -eq 1 ]; then
            scan_dir "$ITEM"
        fi
    done
}
scan_dir "$DIR"
