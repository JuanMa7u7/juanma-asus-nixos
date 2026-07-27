{
  config,
  lib,
  pkgs,
  ...
}:

{
  # ═══════════════════════════════════════════════════════════════
  # CONFIGURACIÓN OFICIAL NATIVA DE LIBVIRT EN NIXOS
  # ═══════════════════════════════════════════════════════════════
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";

    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true; # Soporte para Secure Boot / TPM 2.0
      
      # UNIFICADO: Permisos de Root y ACL estricto para Evdev y tus USBs
      verbatimConfig = ''
        vnc_listen = "0.0.0.0"
        vnc_tls = 0
        user = "root"
        group = "root"
        # Dejamos que Libvirt use su ACL nativo por defecto para que tenga acceso total a los USBs dinámicos
      '';
    };

    extraConfig = ''
      unix_sock_group = "libvirtd"
      unix_sock_ro_perms = "0777"
      unix_sock_rw_perms = "0770"
      auth_unix_ro = "none"
      auth_unix_rw = "none"
      namespaces = []
      clear_emulator_capabilities = 0
      relaxed_acs_check = 1
      macvtap_management = 1
      keep_alive_required = 0
    '';
  };

  # ═══════════════════════════════════════════════════════════════
  # CONFIGURACIONES DE ENTORNO Y BYPASS DE SYSTEMD
  # ═══════════════════════════════════════════════════════════════

  # Permitir el bloqueo de memoria RAM física ilimitada para QEMU
  systemd.services.libvirtd.serviceConfig.LimitMEMLOCK = lib.mkForce "infinity";

  # 🛡️ SOLUCIÓN AL BUG 1: Inyectamos una llave de bypass de exactamente 32 bytes de longitud
  systemd.services.libvirtd.serviceConfig.LoadCredential = lib.mkForce [ "secrets-encryption-key:${pkgs.writeText "dummy-key" "12345678901234567890123456789012"}" ];

  # Añadir tu usuario a los grupos de gestión de la suite
  users.users.juan_ma7u7.extraGroups = [ "libvirtd" "qemu-libvirtd" ];

  # Permitir conexiones de red para VNCViewer en el firewall local
  networking.firewall.allowedTCPPorts = [ 5900 ];

  # Paquetes requeridos del sistema para virtualización gráfica
  environment.systemPackages = with pkgs; [
    virtio-win
    OVMFFull
    spice-gtk
    virt-manager
  ];
}
