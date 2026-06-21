{ pkgs, ... }:
{
  imports = [ ./openrgb.nix ];

  services.flatpak.enable = true;

  boot.supportedFilesystems = [ "ntfs" "exfat" ];
  security.polkit.enable = true;

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    tailscale.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint ];
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    tailscale
    system-config-printer
  ];

  openrgb.enable = true;
}
