{pkgs, ...}: let
  inherit (pkgs.vscode-utils) extensionsFromVscodeMarketplace;

  customExtensions = import ./extensions.nix;
in {
  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    extensions = extensionsFromVscodeMarketplace customExtensions;

    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
