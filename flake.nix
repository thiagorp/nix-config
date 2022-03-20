{
  description = "Thiago's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager }: {
    darwinConfigurations = {
      "Cacos-Macbook-Pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./darwin/configuration.nix home-manager.darwinModule ];
        inputs = { inherit (home-manager.darwinModules) home-manager; };
      };
    };
  };
}
