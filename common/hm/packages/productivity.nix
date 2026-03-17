{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian
    typora
    pomodoro
    gcalcli
    todoist
    todoist-electron
    zk
  ];
}
