#!/usr/bin/env bash

input_text="

"

echo "$input_text" | while IFS= read -r line; do
  if [[ "$line" =~ Updated\ input\ \'([^\']+)\' ]]; then
    name="${BASH_REMATCH[1]}"
  fi
  if [[ "$line" =~ \→.*\(([0-9\-]+)\) ]]; then
    latest_date="${BASH_REMATCH[1]}"
    echo "$name: ($latest_date)"
  fi
done
