{ config, lib, pkgs, ... }:
{
  imports = [ ./system.nix ];

  hardware.graphics.enable = true;
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
      amdvlk
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
