{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/simon/Pictures/Wallpapers/ruffy.jpg"
      ];

      wallpaper = [
        "DP-2, /home/simon/Pictures/Wallpapers/ruffy.jpg"
      ];
    };
  };
}
