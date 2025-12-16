#!/bin/bash

# Usage:
# ./find_niri_window.sh --app-id <app_id>
# ./find_niri_window.sh --title <title>
# ./find_niri_window.sh --app-id <app_id> --exact    # 精确匹配
# ./find_niri_window.sh --title <title> --exact

set -euo pipefail

EXACT_MATCH=false
SEARCH_TYPE=""
SEARCH_VALUE=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --app-id)
            SEARCH_TYPE="app_id"
            SEARCH_VALUE="$2"
            shift 2
            ;;
        --title)
            SEARCH_TYPE="title"
            SEARCH_VALUE="$2"
            shift 2
            ;;
        --exact)
            EXACT_MATCH=true
            shift
            ;;
        *)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
    esac
done

if [[ -z "$SEARCH_TYPE" ]] || [[ -z "$SEARCH_VALUE" ]]; then
    echo "Usage: $0 --app-id <app_id> | --title <title> [--exact]" >&2
    exit 1
fi

# Run niri and capture output
OUTPUT=$(niri msg windows)

# Process line by line
current_id=""
current_title=""
current_app_id=""

while IFS= read -r line; do
    line="${line#"${line%%[![:space:]]*}"}"  # trim leading whitespace

    if [[ $line =~ ^Window\ ID\ ([0-9]+): ]]; then
        current_id="${BASH_REMATCH[1]}"
        current_title=""
        current_app_id=""
    elif [[ $line =~ ^Title:\ \"(.*)\" ]]; then
        current_title="${BASH_REMATCH[1]}"
    elif [[ $line =~ ^App\ ID:\ \"(.*)\" ]]; then
        current_app_id="${BASH_REMATCH[1]}"
    elif [[ $line == "Layout:"* ]]; then
        # We have collected all fields for this window; check if it matches
        if [[ "$SEARCH_TYPE" == "app_id" ]]; then
            if [[ "$EXACT_MATCH" == true ]]; then
                [[ "$current_app_id" == "$SEARCH_VALUE" ]] && echo "$current_id" && exit 0
            else
                [[ "$current_app_id" == *"$SEARCH_VALUE"* ]] && echo "$current_id" && exit 0
            fi
        elif [[ "$SEARCH_TYPE" == "title" ]]; then
            if [[ "$EXACT_MATCH" == true ]]; then
                [[ "$current_title" == "$SEARCH_VALUE" ]] && echo "$current_id" && exit 0
            else
                [[ "$current_title" == *"$SEARCH_VALUE"* ]] && echo "$current_id" && exit 0
            fi
        fi
    fi
done <<< "$OUTPUT"

# No match found
exit 1
