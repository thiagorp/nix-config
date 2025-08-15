{
  config,
  pkgs,
  ...
}: {
  networking.computerName = "Thiago's Work Computer";

  # Work machine specific settings
  environment.systemPackages = with pkgs; [
    # Work-specific tools
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
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      trusted-substituters = [
        "https://cache.mercury.com"
        "https://hydra.iohk.io"
      ];
    };
  };
}
