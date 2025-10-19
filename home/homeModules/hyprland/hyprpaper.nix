{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/simon/Pictures/Wallpapers/animegirl.jpg"
      ];
    };
  };
}
