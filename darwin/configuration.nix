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
    binaryCachePublicKeys =
      [ "cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I=" ];
    trustedBinaryCaches = [ "https://cache.mercury.com" ];
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
