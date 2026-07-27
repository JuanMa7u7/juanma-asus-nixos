{ lib, pkgs, ... }:
{
  imports = [ ./system.nix ./vfio.nix ./virt.nix ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    protontricks.enable = true;
    extest.enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.displayManager.sddm.wayland.enable = lib.mkForce false;

  hardware.nvidia = {
    modesetting.enable = true;

    # REQUIRED en drivers >= 560
    open = true;

    nvidiaSettings = true;
  };

  # Evita el assert de PRIME: en desktop no lo uses
  hardware.nvidia.prime = {
    offload.enable = lib.mkForce false;
    sync.enable = lib.mkForce false;
  };

  # Steam/Proton 32-bit — now merged into hardware.graphics above

  # ═══════════════════════════════════════════════════════════════
  # MENÚ DE ARRANQUE DOBLE REPARADO (Sin aserciones de SDDM)
  # ═══════════════════════════════════════════════════════════════
  specialisation."Windows-Gaming-VM".configuration = {
    system.nixos.tags = [ "VFIO-Windows" ];
    
    # 1. ANULACIÓN DE INTERFAZ GRÁFICA COMPLETA
    services.displayManager.sddm.enable = lib.mkForce false; # <-- APAGA EL MÓDULO ANTES DE LA ASERCIÓN
    services.displayManager.enable = lib.mkForce false;
    services.xserver.enable = lib.mkForce false;
    services.xserver.videoDrivers = lib.mkForce [ ];
    hardware.nvidia.modesetting.enable = lib.mkForce false;
    
    # FORZADO DE SOCKETS
    virtualisation.libvirtd.enable = lib.mkForce true;
    systemd.sockets.libvirtd.enable = lib.mkForce true;
    systemd.services.libvirtd.enable = lib.mkForce true;

    # 2. Silenciar el pánico de aserción del toolkit de NVIDIA
    hardware.nvidia-container-toolkit.enable = lib.mkForce false;
    hardware.nvidia-container-toolkit.suppressNvidiaDriverAssertion = lib.mkForce true;

    # 3. LISTA NEGRA ESTRICTA (Especial para hardware.nvidia.open = true)
    boot.blacklistedKernelModules = [ "nvidia" "nvidia_drm" "nvidia_modeset" "nvidia_uvm" "nouveau" ];

    # Parámetros del kernel para secuestrar el hardware Ada Lovelace
    boot.kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "kvm.ignore_msrs=1"
      "kvm.report_ignored_msrs=0"
      "pcie_aspm=off"
      "vfio-pci.ids=10de:2703,10de:22bc"
      "video=efifb:off"
      "video=vesafb:off"
    ];

    # Forzar la carga de VFIO en el arranque temprano
    boot.initrd.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio-pci" ];

    # Servicio de auto-arranque avanzado (Sintaxis Maestra de Rutas y Comillas Corregida)
    systemd.services.auto-start-windows-vm = {
      description = "Arrancar Windows 11 VM automaticamente en Modo Juego";
      wantedBy = [ "multi-user.target" ];
      after = [ "libvirtd.service" "allocate-hugepages.service" ];
      requires = [ "libvirtd.service" ];
      
      serviceConfig = {
        Type = "oneshot";
        # AUTOMATIZACIÓN MULTIMEDIA DEFINITIVA: Espera a que Windows cargue e inyecta Micro, Cámara y Audífonos
        ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.libvirt}/bin/virsh -c qemu:///system?socket=/var/run/libvirt/libvirt-sock undefine win11-vm1-singlegpu --nvram 2>/dev/null; ${pkgs.libvirt}/bin/virsh -c qemu:///system?socket=/var/run/libvirt/libvirt-sock define ${./vm/win11-vm1-singlegpu/definition.xml} && ${pkgs.libvirt}/bin/virsh -c qemu:///system?socket=/var/run/libvirt/libvirt-sock net-start default 2>/dev/null; ${pkgs.libvirt}/bin/virsh -c qemu:///system?socket=/var/run/libvirt/libvirt-sock start win11-vm1-singlegpu && sleep 15 && echo \"<hostdev mode=\'subsystem\' type=\'usb\'><source><vendor id=\'0x0951\'/><product id=\'0x16df\'/></source></hostdev>\" | ${pkgs.libvirt}/bin/virsh -c qemu:///system?socket=/var/run/libvirt/libvirt-sock attach-device win11-vm1-singlegpu /dev/stdin && echo \"<hostdev mode=\'subsystem\' type=\'usb\'><source><vendor id=\'0x1532\'/><product id=\'0x0e03\'/></source></hostdev>\" | ${pkgs.libvirt}/bin/virsh -c qemu:///system?socket=/var/run/libvirt/libvirt-sock attach-device win11-vm1-singlegpu /dev/stdin && echo \"<hostdev mode=\'subsystem\' type=\'usb\'><source><vendor id=\'0x046d\'/><product id=\'0x0ab5\'/></source></hostdev>\" | ${pkgs.libvirt}/bin/virsh -c qemu:///system?socket=/var/run/libvirt/libvirt-sock attach-device win11-vm1-singlegpu /dev/stdin'";

      };
    };
  };

  boot.kernelModules = [ "v4l2loopback" ];

  # v4l2loopback configuration for BluCast virtual camera
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="BluCast Virtual Camera" exclusive_caps=1 max_buffers=2 max_openers=10
  '';

  # Reglas de Udev unificadas en un solo bloque de texto plano de Nix
  services.udev.extraRules = ''
    SUBSYSTEM=="video4linux", ATTR{name}=="BluCast Virtual Camera", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0951", ATTR{idProduct}=="16df", MODE="0666", GROUP="libvirtd", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="1532", ATTR{idProduct}=="0e03", MODE="0666", GROUP="libvirtd", TAG+="uaccess"
  '';

  hardware.nvidia-container-toolkit = {
    enable = true;
  };
}
