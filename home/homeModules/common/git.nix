{pkgs, ...}: {
  programs.git = {
    enable = true;
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
      signing = {
        format = "openpgp";
        key = "AFA7BD5B3FF3E367";
        signByDefault = true;
      };
    };
  };
}
