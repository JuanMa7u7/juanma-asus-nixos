{ config, lib, pkgs, ... }:
{
  # imports = [ ./system.nix ];

  boot.loader.grub.devices = [ "/dev/sda" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    extraArgs = [
      "-m 10"
      "-s 30"
    ];
  };
}
