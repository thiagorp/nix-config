{ ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;

    coc = {
      enable = true;
      settings = {
        "suggest.echodocSupport" = true;
        "suggest.maxCompleteItemCount" = 20;
        "coc.preferences.formatOnSaveFiletypes" = [
          "javascript"
          "typescript"
          "typescriptreact"
          "json"
          "javascriptreact"
          "typescript.tsx"
          "hs"
          "haskell"
          "sql"
        ];
        "diagnostic.errorSign" = "•";
        "diagnostic.warningSign" = "•";
        "diagnostic.infoSign" = "•";
        "tslint.autoFixOnSave" = true;
        "languageserver" = {
          "haskell" = {
            "command" = "haskell-language-server-wrapper";
            "args" = [ "--lsp" ];
            "initializationOptions" = {
              "languageServerHaskell" = { "formattingProvider" = "fourmolu"; };
            };
            "rootPatterns" = [
              "*.cabal"
              "stack.yaml"
              "cabal.project"
              "package.yaml"
              "hie.yaml"
            ];
            "filetypes" = [ "haskell" "lhaskell" ];
          };
        };
      };
    };
  };
}
