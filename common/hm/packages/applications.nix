{ pkgs, pkgs-edge, pkgs-locked, lib, ... }:
let
  stablePkgs = with pkgs; [
    yazi
    eza
    wasistlos
    kdePackages.kalarm
    kdePackages.networkmanager-qt
  ];

  edgePkgs = with pkgs-edge; [
    vesktop
  ];

  lockedPkgs = with pkgs-locked; [
  ];
in
{
  imports = [
    ./mime.nix
  ];

  home.packages = stablePkgs ++ edgePkgs ++ lockedPkgs;
}
