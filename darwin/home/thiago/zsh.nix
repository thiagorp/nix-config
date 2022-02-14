{ pkgs, ... }:

let
  extras = [ ./zsh/p10k.zsh ./zsh/git.zsh ];

  extraInitExtra =
    builtins.foldl' (soFar: new: soFar + "\n" + builtins.readFile new) ""
    extras;
in {
  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";

    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    dirHashes = {
      dl = "$HOME/Downloads";
      mwb = "$HOME/Code/Mercury/mercury-web-backend";
      mw = "$HOME/Code/Mercury/mercury-web";
    };

    sessionVariables = {
      ARCHFLAGS = "-arch arm64";
      NVIM_TUI_ENABLE_TRUE_COLOR = 1;
    };

    shellAliases = {
      gcb = "git checkout -b";
      gcm = "git checkout master";
      update-nix = "${pkgs.vscode} $HOME/.config/nixpkgs/darwin";
    };

    initExtraFirst = ''
      [ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
    '';

    initExtra = ''
      test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"

      [ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
    '' + extraInitExtra;

    profileExtra = ''
      [ -z "$\{SUDO_COMMAND// }" ] && [ --s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh

      [ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
    '';

    oh-my-zsh = {
      enable = true;

      plugins = [ "git" "node" ];
    };

    zplug = {
      enable = true;
      plugins = [{
        name = "romkatv/powerlevel10k";
        tags = [ "as:theme" "depth:1" ];
      }];
    };
  };
}
