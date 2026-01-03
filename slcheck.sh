#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory"
    exit 1
fi
  scan_dir() {
     local CURRENT_DIR="$1"

     for ITEM in "$CURRENT_DIR"/*; do
       [ -e "$ITEM" ] || continue
       if [ -d "$ITEM" ] && [ ! -L "$ITEM" ]; then
         echo "Directory: $ITEM"
         scan_dir "$ITEM"
       fi
done
}
scan_dir "$DIR"



