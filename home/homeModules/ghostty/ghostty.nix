{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "FantasqueSansM Nerd Font Mono";
      font-size = 18;
      theme = "rose-pine-moon";
      background-opacity = 0.8;
    };
  };
}
