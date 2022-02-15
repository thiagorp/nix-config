{ ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IgnoreUnknown UseKeychain
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_rsa
    '';
  };
}
