{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  sourceLines = map (file: "source ${file}") [./zsh/git.zsh];
in {
  home.packages = [pkgs.oh-my-posh];

  programs.zsh = {
    enable = true;

    dotDir = "${config.home.homeDirectory}/.config/zsh";

    enableCompletion = true;
    syntaxHighlighting.enable = true;

    autosuggestion = {
      enable = true;
    };

    dirHashes = {
      dl = "$HOME/Downloads";
      mwb = "$HOME/Code/Mercury/mercury-web-backend";
      mw = "$HOME/Code/Mercury/mercury-web";
    };

    sessionVariables = {
      ARCHFLAGS = "-arch arm64";
      NVIM_TUI_ENABLE_TRUE_COLOR = 1;
      EDITOR = "nvim";
      SSH_AUTH_SOCK = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    shellAliases = {
      drs = "sudo darwin-rebuild switch --flake ~/.config/nixpkgs";
      gcb = "git checkout -b";
      gcm = "git checkout master";
    };

    initContent = let
      initExtraFirst = lib.mkBefore ''
        export PATH="$PATH:$HOME/.local/bin"
      '';

      initExtra = ''
        test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"

        # Initialize Oh My Posh with custom theme
        eval "$(oh-my-posh init zsh --config ${./zsh/omp-theme.json})"

        ${concatStringsSep "\n" sourceLines}
      '';
    in
      lib.mkMerge [initExtraFirst initExtra];

    oh-my-zsh = {
      enable = true;

      plugins = ["git" "node"];
    };
  };
}
