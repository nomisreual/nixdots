{pkgs, ...}: {
  services.swaync = {
    enable = true;
    style = ''
      * {
       font-family: FantasqueSansM Nerd Font Mono;
      }
    '';
  };
}
