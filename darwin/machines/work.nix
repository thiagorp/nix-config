{
  config,
  pkgs,
  ...
}: {
  networking.computerName = "Thiago's Work Computer";

  environment.systemPackages = with pkgs; [
    gh
  ];

  # Work machine services
  services = {
    # Add work-specific services
  };

  # Work-specific security settings
  security = {
    # Add work security requirements
  };

  nix = {
    settings = {
      trusted-users = ["root" "thiago" "mercury" "nixbld"];
      trusted-public-keys = [
        "cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I="
        "cache.hub.internal.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      trusted-substituters = [
        "https://cache.mercury.com"
        "https://cache.hub.internal.mercury.com"
        "https://hydra.iohk.io"
      ];
      warn-dirty = false;
      max-jobs = "auto";
      min-free = 21474836480;
      max-free = 75161927680;
      tarball-ttl = 86400;
      allow-import-from-derivation = true;
    };
  };
}
