{
  description = "Thiago's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    darwin,
    nixpkgs,
    ...
  } @ inputs: {
    darwinConfigurations = {
      "Cacos-Personal-Computer" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin/configuration.nix
          ./darwin/machines/personal.nix
        ];
        specialArgs = inputs;
      };

      "Thiagos-Work-Computer" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin/configuration.nix
          ./darwin/machines/work.nix
        ];
        specialArgs = inputs;
      };
    };

    devShell.aarch64-darwin = with nixpkgs.legacyPackages.aarch64-darwin;
      mkShell {packages = [alejandra];};
  };
}
