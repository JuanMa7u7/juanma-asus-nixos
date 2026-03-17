{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cmatrix
    ipfetch
    neofetch
    nyancat
  ];
}
