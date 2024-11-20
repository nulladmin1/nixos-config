{...}: {
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
