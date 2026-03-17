{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi
    capitaine-cursors-themed
    waypaper
    waytrogen
    swww
  ];
}
