{ config, pkgs,... }:
{
  config = {
    # Enable kernel modules for motherboard sensors.
    boot.kernelModules = [ "nct6775" "kvm-amd" ];

    # Upadate microcode.
    hardware.cpu.amd.updateMicrocode = true;
  };
}