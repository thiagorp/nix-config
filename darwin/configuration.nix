{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ vim nixfmt ];

  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  services = { nix-daemon = { enable = true; }; };

  networking = { knownNetworkServices = [ "Wi-Fi" "Thunderbolt Bridge" ]; };

  system = {
    stateVersion = 4;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      trackpad = {
        TrackpadThreeFingerDrag = true;
        Clicking = true;
      };

      dock = { autohide = true; };

      finder = { AppleShowAllExtensions = true; };
    };
  };

  nix = {
    trustedUsers = [ "root" "thiago" "mercury" "nixbld" ];
    extraOptions = ''
      extra-substituters = https://cache.mercury.com
      trusted-public-keys = cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
    '';
  };

  networking.computerName = "Caco MacBook Pro";
  networking.hostName = "Cacos-Macbook-Pro";

  users.users = {
    thiago = {
      name = "thiago";
      home = "/Users/thiago";
    };
  };

  home-manager = {
    useUserPackages = true;
    verbose = true;
    users.thiago = (import ./home/thiago);
  };
}
