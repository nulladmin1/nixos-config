alias up := update
alias upc := update-with-commits

default:
    @just --list

update:
    nix flake update

update-with-commits:
    scripts/flake.sh

