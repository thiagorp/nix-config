{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  sourceLines = map (file: "source ${file}") [./zsh/git.zsh];

  zsh-npm-scripts-autocomplete = pkgs.fetchFromGitHub {
    owner = "grigorii-zander";
    repo = "zsh-npm-scripts-autocomplete";
    rev = "5d145e13150acf5dbb01dac6e57e57c357a47a4b";
    sha256 = "sha256-Y34VXOU7b5z+R2SssCmbooVwrlmSxUxkObTV0YtsS50=";
  };
in {
  home.packages = [pkgs.oh-my-posh];

  home.file.".oh-my-zsh-custom/plugins/zsh-npm-scripts-autocomplete".source = zsh-npm-scripts-autocomplete;

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

        # Evaluate direnv for non-interactive shells (e.g., Claude Code)
        if command -v direnv &>/dev/null && [[ -f ".envrc" ]]; then
          eval "$(direnv export zsh)" 2>/dev/null || true
        fi

        # Add Homebrew to PATH if installed (Apple Silicon location)
        [ -d "/opt/homebrew/bin" ] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"

        # Add Node.js global packages to PATH if directory exists
        [ -d "$HOME/.npm-global/bin" ] && export PATH="$HOME/.npm-global/bin:$PATH"

        # Add opencode to PATH if it exists
        [ -d "$HOME/.opencode/bin" ] && export PATH="$HOME/.opencode/bin:$PATH"

        # Add Bugsnag CLI to PATH if installed
        [ -d "$HOME/.local/bugsnag/bin" ] && export PATH="$HOME/.local/bugsnag/bin:$PATH"
      '';

      initExtra = ''
        test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"

        # Initialize Oh My Posh with appropriate theme based on environment
        if [[ -n "$CURSOR_AGENT" ]]; then
          # Use simple prompt for Cursor (no Oh My Posh)
          source ${./zsh/cursor-simple.zsh}
        else
          # Use full theme for other terminals
          eval "$(oh-my-posh init zsh --config ${./zsh/omp-theme.json})"
        fi


        ${concatStringsSep "\n" sourceLines}
      '';
    in
      lib.mkMerge [initExtraFirst initExtra];

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh-custom";
      plugins = ["git" "node" "zsh-npm-scripts-autocomplete"];
    };
  };
}
