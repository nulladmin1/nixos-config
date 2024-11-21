{config, ...}: let
  editor = config.var.editor;
in {
  # Bash:
  programs.bash = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      h = "history | fzf";
      ":q" = "exit";
      meow = "cat";
      vc = "virtualenv venv";
      va = "source ./venv/bin/activate";
      cd = "z";
      please = "sudo ";
      g = "git";
      push = "git push";
      pull = "git pull";
      commit = "git commit -am";
      edithome = "cd ~/nixos-config/ && ${editor} home-manager/home.nix home-manager/packages.nix";
      editsysconf = "cd ~/nixos-config/ && ${editor} system/configuration.nix flake.nix";
      #nvidia-offload = "export __NV_PRIME_RENDER_OFFLOAD=1
      #    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      #    export __GLX_VENDOR_LIBRARY_NAME=nvidia
      #    export __VK_LAYER_NV_optimus=NVIDIA_only
      #    exec '$@'";
      # showcursor = "printf '\033[?25l'";
      # hidecursor = "printf '\033[?25h'";
    };
    bashrcExtra = ''
      nerdfetch
    '';
  };
}
