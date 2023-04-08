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
      tailscale.enable = true;

      # Enable code-server and expose to tailscale network.
      code-server = {
        enable = true;
        host = "100.69.18.110"; # host = "localhost";
        port = 5000;
        user = config-variables.username;
        auth = "password";
        hashedPassword = "$argon2i$v=19$m=4096,t=3,p=1$/1RXd0q6zyni09V+TDN+bg$nt8ut6dya0019jAGRH8YlTfMtDNZlMi4ySbtRLX51KQ";
      };

      # TODO: Setup Caddy to expose code-server through HTTPS to nixos.tail3efa1.ts.net domain.

      # Expose code-server through HTTPS to nixos.tail3efa1.ts.net domain.
      # caddy = {
      #   enable = true;
      #   virtualHosts."nixos.tail3efa1.ts.net".extraConfig = ''
      #     reverse_proxy localhost:5000
      #   '';
      # };

      # caddy = {
      #   enable = true;
      #   virtualHosts."nixos.tail3efa1.ts.net:15000".extraConfig = ''
      #     reverse_proxy localhost:5000
      #   '';
      # };

    };
    
    # Enable Docker.
    virtualisation.docker.enable = true;

   # Enable libvirtd, a daemon that manages virtual machines.
    virtualisation.libvirtd.enable = true;
  };
}