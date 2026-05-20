{ pkgs, lib, ... }:

let
  lubanScript = pkgs.writeShellScriptBin "luban" ''
    LUBAN_DIR="$HOME/.local/share/luban"
    LUBAN_EXE="$LUBAN_DIR/LuBan.exe"
    WINEPREFIX="$LUBAN_DIR/wineprefix"

    if [ ! -f "$LUBAN_EXE" ]; then
      echo "LuBan not found. Please download from:"
      echo "  https://www.luban3d.com/"
      echo ""
      echo "Download the 'Win 32' version and place as:"
      echo "  $LUBAN_EXE"
      exit 1
    fi

    rm -rf "$WINEPREFIX"

    export WINEPREFIX="$WINEPREFIX"
    export WINEARCH=win32
    export WINEDEBUG=-all

    ${pkgs.wine}/bin/wineboot -i

    ${pkgs.wine}/bin/wine "$LUBAN_EXE" "$@"
  '';
in

{
  home.packages = [
    lubanScript
    pkgs.wine
  ];

  xdg.desktopEntries.luBan = {
    name = "LuBan";
    genericName = "3D Generative Design Software";
    comment = "Generative design software for 3D printing, laser cutting, and CNC milling";
    exec = "luban";
    terminal = false;
    categories = [ "Graphics" "3DGraphics" ];
  };
}