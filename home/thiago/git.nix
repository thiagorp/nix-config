{...}: {
  programs.git = {
    enable = true;

    signing.format = null;

    settings = {
      user = {
        name = "Thiago Rodrigues de Paula";
        email = "thiago.rdp@gmail.com";
      };
      alias = {co = "checkout";};
      push = {default = "simple";};
    };

    ignores = ["*.swp" "*.swo" ".DS_Store"];
  };
}
