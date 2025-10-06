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
  } @ inputs: let
    hosts = {
      "Cacos-Personal-Computer" = ./darwin/machines/personal.nix;
      "Thiagos-Work-Computer" = ./darwin/machines/work.nix;
    };

    nfu = with nixpkgs.legacyPackages.aarch64-darwin;
      writeShellScriptBin "nfu" ''
        nix flake update
      '';
  in {
    darwinConfigurations =
      builtins.mapAttrs (
        hostName: configFile:
          darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              ./darwin/configuration.nix
              configFile
            ];
            specialArgs = inputs // {inherit hostName;};
          }
      )
      hosts;

    devShell.aarch64-darwin = with nixpkgs.legacyPackages.aarch64-darwin;
      mkShell {
        packages = [
          alejandra
          nfu
          nodejs_22
        ];
      };
  };
}
