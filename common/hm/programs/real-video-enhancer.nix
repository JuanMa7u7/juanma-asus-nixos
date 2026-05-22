{ lib, pkgs, ... }:

let
  pname = "real-video-enhancer";
  version = "2.4.1";

  src = pkgs.fetchzip {
    url = "https://github.com/TNTwise/REAL-Video-Enhancer/releases/download/RVE-${version}/REAL-Video-Enhancer-${version}-Linux-portable_x86_64.zip";
    hash = "sha256:nhv3pzVQ0ba0lwokENJ+Ldl1EDK8Cc2WS+yW0KP2FR8=";
  };

  realBin = "${src}/REAL-Video-Enhancer";

  libPath = lib.makeLibraryPath [
    pkgs.glib
    pkgs.dbus
    pkgs.libxkbcommon
    pkgs.libxkbcommon.out
    pkgs.xorg.libX11
    pkgs.xorg.libXrandr
    pkgs.xorg.libXcursor
    pkgs.xorg.libXfixes
    pkgs.xorg.xcbutilimage
    pkgs.xorg.xcbutilkeysyms
    pkgs.xorg.xcbutilrenderutil
    pkgs.xorg.xcbutilwm
    pkgs.xorg.xcbutilcursor
    pkgs.libGL
    pkgs.mesa
    pkgs.fontconfig
    pkgs.freetype
    pkgs.libxcb
    pkgs.libxext
    pkgs.libxrender
    pkgs.libdrm
    pkgs.zlib
    pkgs.zstd
    pkgs.stdenv.cc.cc.lib
  ];

  launcher = pkgs.writeShellScriptBin "real-video-enhancer" ''
    export LD_LIBRARY_PATH="${src}/lib:${libPath}:$LD_LIBRARY_PATH"
    export QT_QPA_PLATFORM=xcb
    exec "${realBin}" "$@"
  '';

  icon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/TNTwise/REAL-Video-Enhancer/2.0/icons/logo-v2.svg";
    hash = "sha256:076i4qgzjps62r4q91jza11xr8w5ws0nq9v5km056fk6la97yjzq";
  };
in
{
  home.packages = [ launcher ];

  xdg.desktopEntries.real-video-enhancer = {
    name = "REAL Video Enhancer";
    comment = "AI-powered video upscaling and enhancement";
    exec = "${launcher}/bin/real-video-enhancer %F";
    icon = icon;
    terminal = false;
    type = "Application";
    categories = [
      "Video"
      "Graphics"
      "Utility"
    ];
    mimeType = [ "video/x-matroska" ];
    startupNotify = true;
  };
}