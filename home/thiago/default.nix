{pkgs, ...}: {
  imports = [./direnv.nix ./git.nix ./nvim.nix ./ssh.nix ./vscode ./zsh.nix];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "thiago";
    homeDirectory = "/Users/thiago";

    packages = with pkgs; [bat fzf jq nixpkgs-fmt ripgrep tig watchman yarn];

    stateVersion = "22.05";
  };

  programs.home-manager = {enable = true;};
}
