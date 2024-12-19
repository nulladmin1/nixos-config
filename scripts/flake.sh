#!/usr/bin/env bash

flake_changes=$(nix flake update 2>&1)
commit_message=""

while IFS= read -r line; do 
  if [[ "$line" =~ Updated\ input\ \'([^\']+)\' ]]; then 
      name="${BASH_REMATCH[1]}" 
  fi 
  if [[ "$line" =~ \→.*\(([0-9\-]+)\) ]]; then 
      latest_date="${BASH_REMATCH[1]}" 
      commit_message+="$name: ($latest_date)"$'\n' 
  fi 
done <<< "$flake_changes"

echo "Commit message: "
echo "$commit_message"

git add flake.lock
git commit -m "Update flake inputs
$commit_message"
