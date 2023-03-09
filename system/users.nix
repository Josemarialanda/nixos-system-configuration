{ config, pkgs,... }:
{
  config = {
    # Define user account.
    users.users.josemaria = {
      isNormalUser = true;
      description = "José María Landa Chávez";
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "kvm" ];
    };
  };
}