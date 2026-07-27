{ config, lib, pkgs, ... }:

{
  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio-pci" "kvm-amd" ];
  boot.extraModprobeConfig = "options vfio-pci ids=10de:2703,10de:22bc";

  # Ajustado a 16 GB estables (8192 páginas)
  boot.kernel.sysctl = {
    "vm.nr_hugepages" = 8192;
    "vm.hugetlb_shm_group" = 1000;
  };

  systemd.services.allocate-hugepages = {
    description = "Allocate 16 GB hugepages for Windows VM";
    wantedBy = [ "multi-user.target" ];
    before = [ "libvirtd.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = let
        inherit (pkgs) writeShellScriptBin;
        script = writeShellScriptBin "allocate-hugepages" ''
          echo 8192 > /proc/sys/vm/nr_hugepages
        '';
      in "${script}/bin/allocate-hugepages";
    };
  };
}
