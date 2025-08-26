{ pkgs,... }:

with pkgs.lib;
{

  # 声明选项
  options.hyprpaper-switch = mkOption {
    type = types.package;
    description = "A script to install AUR packages using paru";
  };

  config.hyprpaper-switch = pkgs.writeShellScriptBin "hyprpaper-switch" ''
      #!/usr/bin/env bash

      WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
      CURRENT_WALL=$(hyprctl hyprpaper listloaded)

      # Get a random wallpaper that is not the current one
      WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

      # Apply the selected wallpaper
      hyprctl hyprpaper reload ,"$WALLPAPER"
  '';
}
