#!/usr/bin/env bash

# Colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
COLOR_OFF='\033[0m'

printf "$BLUE Updating flake...$COLOR_OFF\n"
flake_changes=$(nix flake update 2>&1)
commit_message=""
printf "$GREEN Done.$COLOR_OFF\n"


printf "$BLUE Parsing output...$COLOR_OFF\n"
while IFS= read -r line; do 
  if [[ "$line" =~ Updated\ input\ \'([^\']+)\' ]]; then 
      name="${BASH_REMATCH[1]}" 
  fi 
  if [[ "$line" =~ \→.*\(([0-9\-]+)\) ]]; then 
      latest_date="${BASH_REMATCH[1]}" 
      commit_message+="$name: ($latest_date)"$'\n' 
  fi 
done <<< "$flake_changes"

printf "$BLUE Commit message:$COLOR_OFF\n"
printf "$YELLOW $commit_message $COLOR_OFF\n"

printf "$GREEN Adding to Git...$COLOR_OFF\n"
git add flake.lock
git commit -m "Update flake inputs
$commit_message"
printf "$GREEN Done. $COLOR_OFF"
