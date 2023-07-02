{ config, pkgs,... }:

let 
  config-variables = import ../config-variables.nix;
  # create script to prevent system sleep if there is an active SSH connection
  noSleepOnSSH = pkgs.writeScriptBin "noSleepOnSSH" ''
    #!/bin/sh
    sshConnected=$(${pkgs.unixtools.netstat}/bin/netstat -tnp -W 2>/dev/null | ${pkgs.gawk}/bin/gawk '$6 == "ESTABLISHED" && $4 ~ /:22$/ {print "true"; found = 1; exit} END { if (found != 1) print "false" }')
    echo $sshConnected
    if [ "$sshConnected" = "true" ]; then
      # Jiggle the mouse to prevent sleep
      export DISPLAY=:0
      export XAUTHORITY=/run/user/1000/.mutter-Xwaylandauth.IKCS71
      ${pkgs.xdotool}/bin/xdotool mousemove_relative --sync 1 1
      sleep 0.1
      ${pkgs.xdotool}/bin/xdotool mousemove_relative --sync -- -1 -1
      sleep 0.1
      # write to journalctl (include timestamp)
      ${pkgs.util-linux}/bin/logger -t noSleepOnSSH "Active SSH connection, jiggled mouse to prevent sleep"
    else 
      # write to journalctl (include timestamp)
      ${pkgs.util-linux}/bin/logger -t noSleepOnSSH "No active SSH connection"
    fi
  '';
in {
  config = {
    # SystemD services configuration.
    systemd.services = {
      # Disable system sleep if there is an active SSH connection.
      noSleepOnSSH = {
        description = "Prevent system sleep if there is an active SSH connection";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = "300";
          ExecStart = "${noSleepOnSSH}/bin/noSleepOnSSH";
        };
      };
    };

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