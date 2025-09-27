alias up := update
alias upc := update-with-commits

default:
    @just --list

module system name:
    #!/usr/bin/env bash
    set -euo pipefail
    
    if [ "{{system}}" = "home" ]; then dir="modules/home/{{name}}"
    elif [ "{{system}}" = "nixos" ]; then dir="modules/nixos/{{name}}"
    else 
        echo "Incorrect arguments" >&2;
        exit 1; 
    fi

    mkdir -p "$dir"

    cat > "$dir/default.nix" <<EOF
    {
        lib,
        config,
        ...
    }: let
        moduleName = "{{name}}";
    in {
        options.custom.\${moduleName} = {
          enable = lib.options.mkEnableOption moduleName;  
        };

        config = lib.mkIf config.custom.\${moduleName}.enable {
          
        };
    }
    EOF
    
    echo "Module created: $dir"

# Don't use
update:
    nix flake update

# Don't use
update-with-commits:
    scripts/flake.sh

