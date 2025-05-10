{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Simon Antonius Lauer";
    userEmail = "nomisreual@proton.me";
    signing = {
      format = "openpgp";
      key = "AFA7BD5B3FF3E367";
      signByDefault = true;
    };
    extraConfig = {
      init = {
        defaultbranch = "main";
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
