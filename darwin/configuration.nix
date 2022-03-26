{ config, pkgs, home-manager, ... }:

{
  imports = [ home-manager.darwinModule ./homebrew.nix ./postgresql.nix ];

  nixpkgs.overlays = import ./overlays;

  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = with pkgs; [ icu vim nixfmt ];

    # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
    darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

    shells = [ pkgs.zsh ];
  };

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

  programs = { zsh = { enable = true; }; };

  nix = {
    package = pkgs.nix_2_6;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
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
      shell = pkgs.zsh;
    };
  };

  home-manager = {
    useUserPackages = true;
    verbose = true;
    users.thiago = import ../home/thiago;
  };
}
