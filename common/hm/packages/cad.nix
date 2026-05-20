{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    cura-appimage
    orca-slicer
  ];
}
