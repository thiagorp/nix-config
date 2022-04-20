{...}: {
  programs.git = {
    enable = true;

    userName = "Thiago Rodrigues de Paula";
    userEmail = "thiago.rdp@gmail.com";

    aliases = {co = "checkout";};

    extraConfig = {push = {default = "simple";};};

    ignores = ["*.swp" "*.swo" ".DS_Store"];
  };
}
