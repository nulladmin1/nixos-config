{...}: {
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
      meow = "bat";
      please = "sudo ";
      g = "git";
      push = "git push";
      pull = "git pull";
      commit = "git commit -am";
    };
    bashrcExtra = ''
      nerdfetch
    '';
  };
}
