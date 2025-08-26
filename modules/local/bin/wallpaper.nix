{ pkgs, ... }:

with pkgs.lib;
{

  # 声明选项
  options.wallpaper-switch = mkOption {
    type = types.package;
    description = "A script to change wallpaper";
  };

  config.wallpaper-switch = pkgs.writeShellScriptBin "wallpaper-switch" ''
    #!/usr/bin/env bash

    # 从文件读取当前主题名称，如果文件不存在或为空则使用默认值
    THEME_FILE="$HOME/.config/current_theme"
    if [ -f "$THEME_FILE" ] && [ -s "$THEME_FILE" ]; then
        # 读取文件内容并去除可能的空格和换行符
        HYPR_THEME=$(tr -d ' \t\n' < "$THEME_FILE")
    else
        notify-send "警告" "主题文件不存在或为空，使用默认主题"
        HYPR_THEME="default"  # 设置默认主题
    fi

    # 根据主题名称设置壁纸目录
    WALLPAPER_DIR="$HOME/.local/share/hypr-theme/$HYPR_THEME/wallpapers"

    CURRENT_WALL_PATH=$(swww query | grep -oP 'image: \K.*')
    CURRENT_WALL=$(basename "$CURRENT_WALL_PATH")
    # Get a random wallpaper that is not the current one
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

    # Apply the selected wallpaper
    swww img "$WALLPAPER"

    notify-send "壁纸已更新" "已应用: $(basename "$WALLPAPER")"
  '';
}
