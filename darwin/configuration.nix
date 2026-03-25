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
    systemPackages = with pkgs; [
      icu
      vim
      nerd-fonts.meslo-lg
    ];

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

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    settings = {
      extra-substituters = ["https://cache.lix.systems"];
      extra-trusted-public-keys = ["cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="];
    };
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
