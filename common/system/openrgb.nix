{ config, lib, pkgs, ... }:

{
  options.openrgb = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable OpenRGB service for RGB lighting control";
    };
  };

  config = lib.mkIf config.openrgb.enable {
    boot.kernelModules = [ "i2c-dev" ];

    systemd.services.openrgb = {
      description = "OpenRGB Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.openrgb-with-all-plugins}/bin/openrgb --server";
        Restart = "always";
        RestartSec = 5;
        Environment = "OPENRGB_NO_DBUS=1";
      };
    };

    environment.systemPackages = [ pkgs.openrgb-with-all-plugins ];

    users.users.root.extraGroups = [ "i2c" ];
  };
}