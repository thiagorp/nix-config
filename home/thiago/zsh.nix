{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  zplugPlugins = [
    {
      name = "romkatv/powerlevel10k";
      tags = ["as:theme" "depth:1"];
    }
  ];

  sourceLines = map (file: "source ${file}") [./zsh/p10k.zsh ./zsh/git.zsh];
in {
  home.packages = [pkgs.zplug];

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";

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
      drs = "darwin-rebuild switch --flake ~/.config/nixpkgs";
      gcb = "git checkout -b";
      gcm = "git checkout master";
    };

    initExtraFirst = ''
      export PATH="$PATH:$HOME/.local/bin"
      eval "$(fig init zsh pre)"
    '';

    initExtra = ''
      test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"

      ${concatStringsSep "\n" sourceLines}

      eval "$(fig init zsh post)"
    '';

    # Can't use the native zsh implementation because we can't init zplug if we're in a fig terminal
    # See https://github.com/withfig/fig/issues/920
    initExtraBeforeCompInit = ''
      source ${pkgs.zplug}/share/zplug/init.zsh
      export ZPLUG_HOME=${config.home.homeDirectory}/.zplug
      ${optionalString (zplugPlugins != []) ''
        ${concatStrings (map (plugin: ''
            zplug "${plugin.name}"${
              optionalString (plugin.tags != []) ''
                ${concatStrings (map (tag: ", ${tag}") plugin.tags)}
              ''
            }
          '')
          zplugPlugins)}
      ''}
      if ! zplug check; then
        zplug install
      fi

      [[ -z $FIG_PTY ]] && zplug load
    '';

    oh-my-zsh = {
      enable = true;

      plugins = ["git" "node"];
    };
  };
}
