{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    kdePackages.konsole
  ];
}
