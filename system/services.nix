{ config, pkgs,... }:

let 
  config-variables = import ../config-variables.nix;
in {
  config = {
    services = {
      # Enable the OpenSSH daemon.
      openssh.enable = true;

      # Enable SSD TRIM support.
      fstrim.enable = true;

      # Enable CUPS to print documents.
      printing.enable = true;

      # Enable Tailscale client daemon.
      # To run Tailscale, run:          sudo tailscale up
      # To stop Tailscale, run:         sudo tailscale down
      # To check Tailscale status, run: tailscale status
      tailscale.enable = true;

      # Enable code-server and expose to tailscale network.
      # To run code-server, run:     sudo systemctl start code-server@$USER
      # To stop code-server, run:    sudo systemctl stop code-server@$USER
      code-server = {
        enable = true;
        host = "100.69.18.110"; # host = "localhost";
        port = 8080;
        user = config-variables.username;
        auth = "none";
      };

      # TODO: Setup Caddy to expose code-server through HTTPS to nixos.tail3efa1.ts.net domain.

      # Expose code-server through HTTPS to nixos.tail3efa1.ts.net domain.
      # caddy = {
      #   enable = true;
      #   virtualHosts."nixos.tail3efa1.ts.net".extraConfig = ''
      #     reverse_proxy localhost:8080
      #   '';
      # };
      
      # Expose code-server through HTTPS to nixos.tail3efa1.ts.net domain.
      # caddy = {
      #   enable = true;
      #   virtualHosts."nixos.tail3efa1.ts.net:18080".extraConfig = ''
      #     reverse_proxy localhost:8080
      #   '';
      # };

    };
    
    # Enable Docker.
    virtualisation.docker.enable = true;

   # Enable libvirtd, a daemon that manages virtual machines.
    virtualisation.libvirtd.enable = true;
  };
}