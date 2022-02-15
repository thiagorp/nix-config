{ pkgs, ... }:

{
  imports = [ ./git.nix ./nvim.nix ./ssh.nix ./vscode.nix ./zsh.nix ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "thiago";
    homeDirectory = "/Users/thiago";

    packages = with pkgs; [ bat direnv fzf jq nixpkgs-fmt watchman ];

    stateVersion = "22.05";
  };

  programs.home-manager = { enable = true; };
}
