#!/bin/bash

# Verificare număr de argumente
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR="$1"

# Verificare dacă argumentul este un director existent
if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory"
    exit 1
fi

echo "Starting SLCheck on directory: $DIR"
