{
  config,
  pkgs,
  ...
}: {
  networking.computerName = "Caco's Personal Computer";

  # Personal machine specific settings
  environment.systemPackages = with pkgs; [
    claude-code
  ];

  # Personal machine services
  services = {
    # Add personal-specific services
  };
}
