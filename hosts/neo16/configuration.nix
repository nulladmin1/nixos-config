{
  config,
  lib,
  inputs,
  modulesPath,
  ...
}: {
  imports =
    [
      ../../system
      ../../system/hardware/boot/systemd-boot.nix

      inputs.disko.nixosModules.disko
      ./disko.nix

      (modulesPath + "/installer/scan/not-detected.nix")
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel-cpu-only
      common-pc-laptop
      common-pc-laptop-ssd
    ]);

  # --------- DEVICE SPECIFIC STUFF ----------- #

  var.bootloader = "grub";

  networking = {
    hostName = "neo16";
    interfaces = {
      enp109s0.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
    networkmanager.insertNameservers = ["1.1.1.1" "1.0.0.1"];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    initrd.availableKernelModules = ["vmd" "xhci_pci" "thunderbolt" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:01:0:0";
      sync.enable = true;
      offload = {
        enable = !config.hardware.nvidia.prime.sync.enable;
        enableOffloadCmd = !config.hardware.nvidia.prime.sync.enable;
      };
    };
  };

  system.stateVersion = "23.11";
}
