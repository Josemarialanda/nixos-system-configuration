{ config, pkgs, ... }:
let 
  config-variables = import ../config-variables.nix;
in {
  home.packages = with pkgs; [

    # Programming.
    vscode-fhs
    cookiecutter
    meld
    docker-compose
    gh
    nil
    gitea
    tea
    sqliteman
    dbeaver
  
    # Gnome.
    gnome.gnome-tweaks
    gnomeExtensions.systemd-manager
  
    # Icon themes.
    papirus-icon-theme
    kora-icon-theme
  
    # Cursor themes.
    bibata-cursors
      
    # Internet.
    google-chrome
    fragments

    # Social.
    discord
    slack

    # Finance.
    markets
    ledger-live-desktop
     
    # Media.
    spotify
    blanket
    stremio
    shortwave
    vlc
  
    # Office.
    texstudio
    texlive.combined.scheme-full
    lyx
    apostrophe
    drawing
    gaphor
    slides
    libreoffice

    # Utilities.
    dialect
    pdfslicer
    pdftag
    gnome-frog
    pandoc
    gparted
    fsearch
    ventoy-bin
    xautoclick
    textpieces
    sysprof
    virt-manager
    tailscale

    # Terminals.
    blackbox-terminal
    tilix
  
    # System tools.
    htop
    bottom
    pfetch
    ssh-tools
    nix-index
    wget
    ffmpeg
    exa
    ripgrep
    tree
    multitail
    jq
    fx
    jp
    yq
    xxHash
    up
    rmlint
    ntfy
    with-shell
    tldr
    steam-run
    trash-cli
    retry
    viddy
    concurrently
    http-prompt
    detox
    git-sync
    sox
    catimg
    bc
    clac
    rlwrap
    wtf
    pipr
    xsensors
    psensor
  ];

  # Configurable programs.
  programs = {

    # Enable MangoHud.
    mangohud = {
      enable = true;
      settings = {
        gpu_temp = "1";
        cpu_temp = "1";
        vram     = "1";
        ram      = "1";
      };
    };
  
    # Enable direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  
    # Install the Java development kit and set the JAVA_HOME variable.
    java.enable = true;
  
    # Configure git
    git = {
      enable = true;
      userName = config-variables.gitUsername;
      userEmail = config-variables.email;
    };
  
    # Enable bat: a better cat
    bat = {
      enable = true;
      config = {
        theme = "Dracula";
        style = "numbers,changes,header,grid";
      };
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        character = {
          success_symbol = "⚡";
          error_symbol = "🔥";
        };
        cmd_duration = {
          min_time = 500;
          format = "🕑:[$duration](bold yellow)";
        };
      };
    };
  
    # Bash configuration
    bash = {
      enable = true;
  
      # Shell aliases
      shellAliases = {

        # Show active SSH connections (IP address and hostname)
        active-ssh-connections = "netstat -tnp -W 2>/dev/null | awk '$6 == \"ESTABLISHED\" && $4 ~ /:22$/ {split($5, a, \":\"); cmd = \"host \" a[1]; cmd | getline hostname; close(cmd); split(hostname, b, \" \"); print a[1], \"(\" b[5] \")\"; exit}'";

        # Check if there are active SSH connections
        has-ssh-connections = "netstat -tnp -W 2>/dev/null | awk '\$6 == \"ESTABLISHED\" && \$4 ~ /:22\$/ {print \"true\"; found = 1; exit} END { if (found != 1) print \"false\" }'";
  
        # Variations of ls
        ll = "ls -l";
        lo = "ls -o";
        lh = "ls -lh";
        la = "ls -la";
  
        # confirm before overwriting something
        "cp" = "cp -i";
        "mv" = "mv -i";
        "rm" = "rm -i";
  
        # git
        addup = "git add -u";
        addall = "git add .";
        branch = "git branch";
  	    checkout = "git checkout";
  	    clone = "git clone";
  	    commit = "git commit -m";
  	    fetch = "git fetch";
  	    pull = "git pull origin";
  	    push = "git push origin";
  	    stat = "git status";
  	    tag = "git tag";
  	    newtag = "git tag -a";
  
        # get error messages from journalctl
        jctl = "journalctl -p 3 -xb";
           
        # Disk space information
        diskspace = "du -S | sort -n -r |more";
      
        # Show the size (sorted) of the folders in this directory
        folders = "find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn";
  
        # Aliases for moving up directories
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
  
        # NixOS aliases
        nixos-clean = "sudo nix-collect-garbage -d"; # system cleanup
        nixos-optimise = "nix-store --optimise";
  
        # nix-env aliases
        nix-install = "nix-env -i";
        nix-search = "nix search";
        nix-undo = "nix-env --rollback";
        nix-generations = "nix-env --list-generations";
        nix-upgrade = "nix-env -u";
        nix-remove = "nix-env -e";
        nix-list = "nix-env --query";
        nix-clean = "nix-collect-garbage -d"; # user specific cleanup
      };
  
      # Bash config file
      bashrcExtra = ''
        export EDITOR='kak'
        export VISUAL='kak'
      '';
        
      # Commands that should be run when initializing an interactive shell
      initExtra = ''
         pfetch
      '';
    };
  
    kakoune = {
      enable = true;
      config = {
  	    tabStop = 2;
        alignWithTabs = true;
        autoComplete = [ "insert" "prompt" ];
        autoInfo = [ "command" "onkey" ];
        autoReload = "ask";
        colorScheme = "dracula";
        indentWidth = 0;
        numberLines = {
        enable = true;
        highlightCursor = true;
        separator = "|";
      };
      ui = {
        enableMouse = true;
        assistant = "dilbert";
        setTitle = true;
      };
      wrapLines = {
        enable = true;
        indent = true;
        marker = "⏎";
      };
      };
    plugins = [ 
      pkgs.kakounePlugins.powerline-kak
      pkgs.kakounePlugins.kakoune-rainbow
      pkgs.kakounePlugins.kakoune-vertical-selection
    ];
    extraConfig = ''
      set-face global Default rgb:f8f8f2,default
    '';
    };
  };
}