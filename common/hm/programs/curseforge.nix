{ lib, pkgs, ... }:

let
  pname = "curseforge";
  version = "9999.9999.9999";

  src = pkgs.fetchurl {
    url = "https://curseforge.overwolf.com/downloads/curseforge-latest-linux.AppImage";
    hash = "sha256-LZlOEGSNdVZMaLJx6pfwLaDeW4kHsDRszMiOYQjRvQk=";
  };

  icon = ./icons/curseforge-icon.png;

  extracted = pkgs.appimageTools.extract {
    inherit pname version src;
  };

  appimageLibs = "${extracted}/usr/lib";

  libPath = pkgs.lib.makeLibraryPath [
    pkgs.glib
    pkgs.cairo
    pkgs.pango
    pkgs.gdk-pixbuf
    pkgs.atk
    pkgs.at-spi2-core
    pkgs.pango
    pkgs.gtk3
    pkgs.nspr
    pkgs.nss
    pkgs.dbus
    pkgs.dbus-glib
    pkgs.gst_all_1.gstreamer
    pkgs.gst_all_1.gst-plugins-base
    pkgs.cups
    pkgs.libsecret
    pkgs.libva
    pkgs.libdrm
    pkgs.libvpx
    pkgs.ffmpeg
    pkgs.xorg.libX11
    pkgs.xorg.libXext
    pkgs.xorg.libXrender
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXdamage
    pkgs.xorg.libXrandr
    pkgs.xorg.libXScrnSaver
    pkgs.xorg.libxkbfile
    pkgs.xorg.libXcursor
    pkgs.xorg.libXfixes
    pkgs.xorg.libXi
    pkgs.xorg.libXinerama
    pkgs.xorg.libXmu
    pkgs.xorg.libXpm
    pkgs.xorg.libXtst
    pkgs.libxkbcommon
    pkgs.pcre
    pkgs.zlib
    pkgs.bzip2
    pkgs.mesa
    pkgs.libgbm
    pkgs.expat
    pkgs.libxcb
    pkgs.xorg.libX11
    pkgs.alsa-lib
    pkgs.mesa.drivers
    pkgs.libglvnd
  ];

  wrapped = pkgs.writeShellScriptBin "curseforge" ''
    export ELECTRON_OZONE_PLATFORM_HINT=auto
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_TYPE=wayland
    export WAYLAND_DISPLAY=$WAYLAND_DISPLAY
    export DISPLAY=$DISPLAY
    export ELECTRON_DISABLE_SANDBOX=1
    export LD_LIBRARY_PATH="${appimageLibs}:${libPath}:$LD_LIBRARY_PATH"
    exec ${extracted}/curseforge --no-sandbox "$@"
  '';
in
{
  home.packages = [ wrapped ];

  xdg.desktopEntries.curseforge = {
    name = "Curseforge";
    comment = "Game mod manager and downloader";
    exec = "${lib.getExe wrapped}";
    icon = "curseforge";
    terminal = false;
    type = "Application";
    categories = [
      "Game"
      "Utility"
    ];
    startupNotify = true;
  };
}