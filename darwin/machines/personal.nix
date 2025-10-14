{
  config,
  pkgs,
  ...
}: {
  networking.computerName = "Caco's Personal Computer";

  # Personal machine specific settings
  environment.systemPackages = with pkgs; [
    claude-code
    codex
  ];

  # Personal machine services
  services = {
    # Add personal-specific services
  };
}
