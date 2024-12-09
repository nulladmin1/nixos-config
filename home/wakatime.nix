{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.wakanix.homeManagerModules.wakanix
  ];

  programs.wakanix = {
    enable = true;

    settings.api = {
      url = "https://waka.hackclub.com/api";
      key = builtins.readFile config.sops.secrets."hackclub-wakatime-api-key".path;
    };
  };
}
