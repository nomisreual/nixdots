{pkgs, ...}: {
  programs.git = {
    enable = true;
    signing = {
      format = "openpgp";
      key = "AFA7BD5B3FF3E367";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Simon Antonius Lauer";
        email = "nomisreual@proton.me";
      };
      init = {
        defaultbranch = "main";
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
