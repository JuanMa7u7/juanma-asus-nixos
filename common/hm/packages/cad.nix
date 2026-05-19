{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    cura-appimage
    snapmaker-luban
  ];
}
