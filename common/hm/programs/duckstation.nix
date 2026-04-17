{ lib, pkgs, ... }:

let
  pname = "duckstation";
  version = "0.1-10998";

  src = pkgs.fetchurl {
    url = "https://github.com/stenzek/duckstation/releases/download/v${version}/DuckStation-x64.AppImage";
    hash = "sha256:b204886bb498ede1a290215fc2efb521c0c2f26b964788df697b4fc2cb3f7f7b";
  };

  icon = pkgs.fetchurl {
    url = "https://duckstation.org/assets/img/duck.svg";
    hash = "sha256:65c07f0b93b9be9fb5469f37119cfa39e193c5b3da438e7c3b47d37bc7e637c0";
  };

  duckstation = pkgs.appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      if [ -e "$out/bin/${pname}-${version}" ]; then
        mv "$out/bin/${pname}-${version}" "$out/bin/${pname}"
      fi

      install -Dm644 ${icon} "$out/share/icons/hicolor/scalable/apps/${pname}.svg"
    '';

    meta = with lib; {
      description = "PS1 Emulator";
      homepage = "https://duckstation.org/";
      sourceProvenance = with sourceTypes; [ binaryNativeCode ];
      platforms = [ "x86_64-linux" ];
      mainProgram = pname;
    };
  };
in
{
  home.packages = [ duckstation ];

  xdg.desktopEntries.duckstation = {
    name = "DuckStation";
    comment = "PS1 Emulator";
    exec = "${lib.getExe duckstation}";
    icon = "duckstation";
    terminal = false;
    type = "Application";
    categories = [
      "Game"
      "Utility"
    ];
    startupNotify = true;
  };
}