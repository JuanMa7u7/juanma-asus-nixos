{ pkgs, pkgs-edge, pkgs-locked, inputs, lib, ... }:
let
  system = "x86_64-linux";

  gpartedWrapper = pkgs.writeShellScriptBin "gparted" ''
    exec pkexec --disable-internal-agent \
      env \
      DISPLAY="$DISPLAY" \
      XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}" \
      GDK_BACKEND=x11 \
      WAYLAND_DISPLAY= \
      "${pkgs.gparted-full}/libexec/gpartedbin" "$@"
  '';

  stablePkgs = with pkgs; [
    _1password-cli
    _1password-gui
    yazi
    eza
    kitty
    firefox
    bottles
    brave
    chromium
    google-chrome
    gnome-disk-utility
    cmatrix
    ipfetch
    kdePackages.konsole
    kdePackages.kalarm
    kdePackages.networkmanager-qt
    neofetch
    nyancat
    obsidian
    obs-studio
    onlyoffice-desktopeditors
    pomodoro
    rofi
    sunvox
    typora
    transmission_4-gtk
    libreoffice
    gcalcli
    todoist
    todoist-electron
    signal-desktop
    zoom-us
    zk
    image-roll
    capitaine-cursors-themed
    telegram-desktop
    thunderbird-bin
    wasistlos
    waypaper
    waytrogen
    x11vnc
    swww
    cura-appimage
    ktailctl
    gparted-full
    nvidia-container-toolkit
    nvidia-docker
    blender
    # v4l2loopback
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

  home.packages = stablePkgs ++ edgePkgs ++ lockedPkgs ++ [
    inputs.zen-browser.packages."${system}".beta
    (lib.hiPrio gpartedWrapper)
  ];

  xdg.desktopEntries.gparted = {
    name = "GParted";
    genericName = "Partition Editor";
    comment = "Create, reorganize, and delete partitions";
    exec = "gparted %f";
    icon = "gparted";
    terminal = false;
    categories = [
      "GNOME"
      "System"
      "Filesystem"
    ];
  };
}
