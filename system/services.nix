{ config, pkgs,... }:
{
  config = {
    services = {
      # Enable the OpenSSH daemon.
      openssh.enable = true;

      # Enable SSD TRIM support.
      fstrim.enable = true;

      # Enable CUPS to print documents.
      printing.enable = true;
    };
    
    # Enable Docker.
    virtualisation.docker.enable = true;
  };
}