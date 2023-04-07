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

      # Enable Tailscale client daemon.
      tailscale = {
        enable = true;
        permitCertUid = "josemaria";
      };
    };
    
    # Enable Docker.
    virtualisation.docker.enable = true;

   # Enable libvirtd, a daemon that manages virtual machines.
    virtualisation.libvirtd.enable = true;
  };
}