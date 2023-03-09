# Build with nixos-rebuild build --impure --flake .#
# Switch with nixos-rebuild boot/switch --impure --flake .#

{
  description = "NixOS system configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
	    url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: 
  let system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      josemaria = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./user/home.nix ];
      };
    };
    nixosConfigurations = {
      nixos = lib.nixosSystem { 
        inherit system; 
        modules = [ ./system/configuration.nix ]; 
      };
    };
  };
}