{ config, pkgs,... }:
{
  config = {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    # Use the latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Enable NTFS support.
    boot.supportedFilesystems = [ "ntfs" ];

    # Enable nix flakes.
    nix = {
     package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };
  };
}