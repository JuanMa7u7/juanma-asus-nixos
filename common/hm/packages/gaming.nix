{ pkgs, pkgs-edge, inputs, ... }:
let
  stablePkgs = with pkgs; [
    gamemode
    mangohud
    lutris
    sidequest
    android-tools
    protonup-ng
    gamescope
    protontricks
    steam-run
    vulkan-tools
    winetricks
    protonup-qt
    mangojuice
    openrgb-with-all-plugins
    lsfg-vk
    piper
    libratbag
    bottles
    prismlauncher
    inputs.trinity-launcher.packages.${pkgs.system}.default
  ];
  edgePkgs = with pkgs-edge; [
  ];
in
{
  home.packages = stablePkgs ++ edgePkgs;
}
