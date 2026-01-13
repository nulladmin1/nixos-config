{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:01:0:0";
      sync.enable = false;
      offload = {
        enable = !config.hardware.nvidia.prime.sync.enable;
        enableOffloadCmd = !config.hardware.nvidia.prime.sync.enable;
      };
    };
  };
}
