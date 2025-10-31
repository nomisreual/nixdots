{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        # "/home/simon/Pictures/Wallpapers/animegirl.jpg"
        "/home/simon/Pictures/Wallpapers/nix-wallpaper-binary-black.png"
      ];
    };
  };
}
