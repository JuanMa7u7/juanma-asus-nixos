{ pkgs, ... }:
{
  home.packages = with pkgs; [
    signal-desktop
    zoom-us
    telegram-desktop
    thunderbird-bin
  ];
}
