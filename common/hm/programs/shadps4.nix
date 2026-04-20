{ lib, pkgs, ... }:

let
  pname = "shadps4";
  version = "224";

  src = pkgs.fetchzip {
    url = "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/v${version}/shadPS4QtLauncher-linux-qt-v224.zip";
    hash = "sha256-/h/ZPZ2c1WehizJWY719r8OXhZk0UO9/hr6fxtiK7mo=";
  };

  appimageFile = "${src}/shadPS4QtLauncher-qt.AppImage";

  icon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/shadps4-emu/shadPS4/main/.github/shadps4.png";
    hash = "sha256:af26b4a139c5cd2d03e3c61c075f007af330fffabef2ddec510c230c2f4b4795";
  };

  launcher = let
    libPath = lib.makeLibraryPath [
      pkgs.libglvnd
      pkgs.libxkbcommon
      pkgs.xorg.libX11
      pkgs.xorg.libXrandr
      pkgs.xorg.libXcursor
      pkgs.xorg.libXfixes
      pkgs.libGL
      pkgs.fontconfig
      pkgs.freetype
      pkgs.libxcb
      pkgs.e2fsprogs
      pkgs.libxext
      pkgs.libxrender
      pkgs.xcbutil
      pkgs.xcbutilwm
      pkgs.xcbutilimage
      pkgs.xcbutilkeysyms
      pkgs.xcbutilrenderutil
      pkgs.libdrm
    ];
  in pkgs.writeShellScriptBin "shadps4" ''
    export QT_QPA_PLATFORM=xcb
    export SDL_VIDEODRIVER=x11
    export APPIMAGE_EXTRACT_AND_RUN=1
    export LD_LIBRARY_PATH="${libPath}:$LD_LIBRARY_PATH"
    exec "${appimageFile}" "$@"
  '';
in
{
  home.packages = [ launcher ];

  xdg.desktopEntries.shadps4 = {
    name = "ShadPS4";
    comment = "PS4 Emulator";
    exec = "${launcher}/bin/shadps4";
    icon = "shadps4";
    terminal = false;
    type = "Application";
    categories = [
      "Game"
      "Utility"
    ];
    startupNotify = true;
  };
}