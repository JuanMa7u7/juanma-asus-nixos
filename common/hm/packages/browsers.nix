{ pkgs, pkgs-edge, inputs, ... }:
let
  system = "x86_64-linux";
in
{
  home.packages = with pkgs; [
    firefox
    brave
    chromium
    google-chrome
  ] ++ [
    inputs.zen-browser.packages."${system}".beta
  ];
}
