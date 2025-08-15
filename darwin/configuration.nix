{
  config,
  pkgs,
  home-manager,
  hostName,
  ...
}: {
  imports = [home-manager.darwinModules.home-manager ./postgresql.nix];

  ids.gids.nixbld = 350;

  nixpkgs.overlays = import ./overlays;

  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = with pkgs; [icu vim];

    # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
    darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

    shells = [pkgs.zsh];
  };

  networking = {knownNetworkServices = ["Wi-Fi" "Thunderbolt Bridge"];};

  system = {
    stateVersion = 6;
    primaryUser = "thiago";

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      trackpad = {
        TrackpadThreeFingerDrag = true;
        Clicking = true;
      };

      dock = {autohide = true;};

      finder = {AppleShowAllExtensions = true;};
    };
  };

  programs = {zsh = {enable = true;};};

  nix = {
    enable = true;

    package = pkgs.nixVersions.stable;

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  users.users = {
    thiago = {
      name = "thiago";
      home = "/Users/thiago";
      shell = pkgs.zsh;
    };
  };

  networking.hostName = hostName;

  home-manager = {
    useUserPackages = true;
    verbose = true;
    users.thiago = import ../home/thiago;
  };
}
