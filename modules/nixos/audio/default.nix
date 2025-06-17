{
  lib,
  config,
  ...
}: let
  moduleName = "audio";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services.pulseaudio.enable = false;
    services.playerctld.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      audio.enable = true;
      wireplumber.enable = true;
    };
  };
}
