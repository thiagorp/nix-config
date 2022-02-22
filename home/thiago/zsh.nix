{ pkgs, config, lib, ... }:

with lib;

let
  extras = [ ./zsh/p10k.zsh ./zsh/git.zsh ];

  extraInitExtra =
    builtins.foldl' (soFar: new: soFar + "\n" + builtins.readFile new) ""
    extras;

  zplugPlugins = [{
    name = "romkatv/powerlevel10k";
    tags = [ "as:theme" "depth:1" ];
  }];
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
      EDITOR = "nvim";
    };

    shellAliases = {
      drs = "darwin-rebuild switch";
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

    # Can't use the native zsh implementation because we can't init zplug if we're in a fig terminal
    # See https://github.com/withfig/fig/issues/920
    initExtraBeforeCompInit = ''
      source ${pkgs.zplug}/init.zsh
      export ZPLUG_HOME=${config.home.homeDirectory}/.zplug
      ${optionalString (zplugPlugins != [ ]) ''
        ${concatStrings (map (plugin: ''
          zplug "${plugin.name}"${
            optionalString (plugin.tags != [ ]) ''
              ${concatStrings (map (tag: ", ${tag}") plugin.tags)}
            ''
          }
        '') zplugPlugins)}
      ''}
      if ! zplug check; then
        zplug install
      fi

      [[ -z $FIG_PTY ]] && zplug load
    '';

    profileExtra = ''
      [ -z "$\{SUDO_COMMAND// }" ] && [ --s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh

      [ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
    '';

    oh-my-zsh = {
      enable = true;

      plugins = [ "git" "node" ];
    };
  };
}
