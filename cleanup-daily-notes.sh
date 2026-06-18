#!/bin/bash
DAILY_DIR="$HOME/Your/Vault/Directory/Path"
MAX_AGE_DAYS=10

today=$(date +%s)

for file in "$DAILY_NOTES_DIRECTORY"/*.md; do
    [ -f "$file" ] || continue
    basename=$(basename "$file" .md)
    file_date=$(date -d "$(echo "$basename" | awk -F- '{print $3"-"$2"-"$1}')" +%s 2>/dev/null) || continue
    age_days=$(( (today - file_date) / 86400 ))
    if [ "$age_days" -gt "$MAX_AGE_DAYS" ]; then
        rm "$file"
    fi
done
