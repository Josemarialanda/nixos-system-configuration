{ config, pkgs,... }:
let 
  config-variables = import ../config-variables.nix;
in {
  config.networking = {
    # Setup networking.
    networkmanager.enable = true;
    hostName = config-variables.hostname;

    # Open ports 80 and 443 for HTTP and HTTPS.
    firewall.allowedTCPPorts = [ 80 443 8080 ];
  };
}