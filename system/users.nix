{ config, pkgs,... }:
let 
  config-variables = import ../config-variables.nix;
in {
  config = {
    # Define user account.
    users.users.${config-variables.username} = {
      isNormalUser = true;
      description = config-variables.userDesc;
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "kvm" ];
    };
  };
}