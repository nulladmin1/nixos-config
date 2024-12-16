{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      vim

      wget
      unzip
      efibootmgr
      ffmpeg-full
      alacritty
      vlc
      protonup
      sbctl

      # Dev
      git
      go
      python3
      rustup
      alejandra
      nil
    ]
    ++ [
      # My custom Nixvim configuration
      inputs.nixvim.packages.${pkgs.system}.default
    ];
}
