{ pkgs, ... }:

let
  inherit (pkgs.vscode-utils) extensionsFromVscodeMarketplace;

  customExtensions = import ./extensions.nix;

in {
  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    extensions = extensionsFromVscodeMarketplace customExtensions;

    userSettings = {
      "editor.tabSize" = 2;
      "editor.minimap.enabled" = false;
      "editor.multiCursorModifier" = "alt";
      "explorer.confirmDragAndDrop" = false;
      "extensions.autoUpdate" = false;
      "files.associations" = {
        "*.hs" = "haskell";
        "*.cjs" = "javascript";
      };
      "gitlens.views.compare.files.layout" = "list";
      "git.enableSmartCommit" = true;
      "[json]" = {
        "editor.defaultFormatter" = "vscode.json-language-features";
      };
      "diffEditor.ignoreTrimWhitespace" = false;
      "terminal.integrated.rendererType" = "dom";
      "[html]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
      "editor.formatOnSave" = true;
      "[jsonc]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
      "gitlens.codeLens.enabled" = false;
      "tslint.configFile" = "tslint.json";
      "tslint.packageManager" = "yarn";
      "debug.node.autoAttach" = "on";
      "prettier.singleQuote" = true;
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "eslint.validate" =
        [ "javascript" "javascriptreact" "typescript" "typescriptreact" ];
      "eslint.lintTask.enable" = true;
      "editor.codeActionsOnSave" = {
        "source.fixAll" = true;
        "source.fixAll.eslint" = true;
        "source.organizeImports" = true;
        "source.sortMembers" = true;
      };
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "[css]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
      "[scss]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
      "[yaml]" = {
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
        "editor.autoIndent" = "keep";
        "gitlens.codeLens.scopes" = [ "document" ];
        "editor.quickSuggestions" = {
          "other" = true;
          "comments" = false;
          "strings" = true;
        };
      };
      "svelte.enable-ts-plugin" = true;
      "javascript.inlayHints.enumMemberValues.enabled" = true;
      "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
      "typescript.inlayHints.enumMemberValues.enabled" = true;
      "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
      "typescript.inlayHints.parameterNames.enabled" = "all";
      "typescript.inlayHints.parameterTypes.enabled" = true;
      "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
      "typescript.inlayHints.variableTypes.enabled" = true;
      "typescript.preferences.importModuleSpecifierEnding" = "minimal";
      "javascript.preferences.importModuleSpecifierEnding" = "minimal";
      "haskell.formattingProvider" = "fourmolu";
      "files.exclude" = { "**/.stack-work" = true; };
      "pgFormatter.keywordCase" = "lowercase";
      "pgFormatter.functionCase" = "lowercase";
      "[haskell]" = { "editor.defaultFormatter" = "haskell.haskell"; };
      "[svelte]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
      "terminal.integrated.env.osx" = { "FIG_NEW_SESSION" = "1"; };
      "terminal.external.osxExec" = "iTerm2.app";
      "terminal.integrated.fontFamily" = "MesloLGS NF";
      "editor.accessibilitySupport" = "off";
      "javascript.preferences.importModuleSpecifier" = "non-relative";
      "workbench.colorTheme" = "GitHub Dark Default";
      "typescript.preferences.importModuleSpecifier" = "non-relative";
      "git.path" = "${pkgs.git}/bin/git";
    };

  };
}
