{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Use the latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable SSD TRIM support.
  services.fstrim.enable = true;

  # Enable NTFS support.
  boot.supportedFilesystems = [ "ntfs" ];

  # Enable kernel modules for motherboard sensors.
  boot.kernelModules = [ "nct6775" "kvm-amd" ];

  # Upadate microcode.
  hardware.cpu.amd.updateMicrocode = true;

  # Setup networking.
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_MX.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_MX.UTF-8";
    LC_IDENTIFICATION = "es_MX.UTF-8";
    LC_MEASUREMENT = "es_MX.UTF-8";
    LC_MONETARY = "es_MX.UTF-8";
    LC_NAME = "es_MX.UTF-8";
    LC_NUMERIC = "es_MX.UTF-8";
    LC_PAPER = "es_MX.UTF-8";
    LC_TELEPHONE = "es_MX.UTF-8";
    LC_TIME = "es_MX.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Stop Ugreen usb dock from waking up computer.
  services.udev.extraRules = ''
    ACTION=="add", ATTRS{idVendor}=="05e3", ATTRS{idProduct}=="0610", ATTR{power/wakeup}="disabled"
    ACTION=="add", ATTRS{idVendor}=="05e3", ATTRS{idProduct}=="0626", ATTR{power/wakeup}="disabled"
  '';

  # Configure keymap in X11.
  services.xserver = {
    layout = "es";
    xkbVariant = "";
  };

  # Configure console keymap.
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define user account.
  users.users.josemaria = {
    isNormalUser = true;
    description = "José María Landa Chávez";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "kvm" ];
  };

  # Enable nix flakes.
  nix = {
   package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # System fonts.
  fonts.fonts = with pkgs ; [
    fira-code
    cascadia-code
  ];
  
  # Enable Logitech wireless devices.
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Docker.
  virtualisation.docker.enable = true;

  # Automatic nix store storage optimization.
  nix.settings.auto-optimise-store = true;

  system.stateVersion = "22.11";
}
