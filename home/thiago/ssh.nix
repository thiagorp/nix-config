{...}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        IgnoreUnknown UseKeychain
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/github

      Host *
        IgnoreUnknown UseKeychain
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_rsa
    '';
  };
}
