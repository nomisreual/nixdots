{pkgs, ...}: {
  programs.wofi = {
    enable = true;
    style = builtins.readFile ./catppuccin_mocha.css;
  };
}
