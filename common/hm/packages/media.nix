{ pkgs, pkgs-edge, ... }:
let
  stablePkgs = with pkgs; [
    cava
    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    crosspipe
    easyeffects
    qjackctl
    rtaudio
    gimp3-with-plugins
    gnome-network-displays
    miraclecast
    nwg-look
    vlc
    mpc-qt
    obs-studio
    sunvox
    image-roll
  ];
  edgePkgs = with pkgs-edge; [
  ];
in
{
  home.packages = stablePkgs ++ edgePkgs;
}
