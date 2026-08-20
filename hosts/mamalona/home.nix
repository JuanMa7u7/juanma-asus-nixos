{ pkgs, ... }:
{
  imports = [];

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    nvidia-container-toolkit
    nvidia-docker
  ];

  services.blucast.enable = true;
  services.sc0710-audio.enable = true;

  home.sessionVariables = {
    STEAMLIBRARY = "/mnt/juegos-ssd/SteamLibrary";
    STEAMLIBRARY_SSD = "/mnt/juegos-ssd/SteamLibrary";
    STEAMLIBRARY_HDD = "/mnt/juegos-hdd/SteamLibrary";
    PRESSURE_VESSEL_FILESYSTEMS_RW =
      "\${HOME}:/mnt/juegos-ssd:/mnt/juegos-hdd:/mnt/datos";
  };
}
