{ config, pkgs, ... }:

with pkgs.lib;
{
  options = {
    theme-switcher = mkOption {
      type = types.package;
      description = "A script to switch the theme";
    };
    activeTheme = mkOption {
      type = types.string;
      default = "Catppuccin-Mocha";
      description = "The currently active theme";
    };
  };

  # 当前激活的主题
  config.activeTheme = config.home.sessionVariables.HYPR_THEME or "Catppuccin-Mocha";

  # 主题切换脚本
  config.theme-switcher = pkgs.writeShellScriptBin "theme-switcher" ''
    #!/bin/bash

    THEMES_ROOT="$HOME/.local/share/hypr-theme/"
    CONFIG_ROOT="$HOME/.config"
    CURRENT_THEME_FILE="$HOME/.config/current_theme"

    # 获取所有可用主题
    get_themes() {
      find "$THEMES_ROOT" -maxdepth 1 -type d ! -path "$THEMES_ROOT" -exec basename {} \; 2>/dev/null | sort
    }

    # 应用主题配置
    apply_theme() {
      local theme_name="$1"
      local theme_dir="''${THEMES_ROOT%/}/$theme_name"

      # 检查主题是否存在
      if [ ! -d "$theme_dir" ]; then
        notify-send "错误" "主题不存在: $theme_name"
        return 1
      fi

      # 更新当前主题记录
      echo "$theme_name" > "$CURRENT_THEME_FILE"

      # Waybar配置
      if [ -f "$theme_dir/waybar.theme" ]; then
        ln -sf "$theme_dir/waybar.theme" "$CONFIG_ROOT/waybar/theme.css"
        echo "✓ Waybar 主题已应用"
      fi

      # Kitty配置
      if [ -f "$theme_dir/kitty.theme" ]; then
        ln -sf "$theme_dir/kitty.theme" "$CONFIG_ROOT/kitty/theme.conf"
        pkill -USR1 kitty 2>/dev/null && echo "✓ Kitty 主题已重载"
      fi

      # 重启Waybar
      pkill waybar 2>/dev/null
      sleep 0.2
      waybar > /dev/null 2>&1 &

      notify-send "主题已切换" "已应用: $theme_name" -a "Theme Switcher"
    }

    # 显示主题选择菜单
    show_menu() {
      local themes_list=($(get_themes))

      if [ ''${#themes_list[@]} -eq 0 ]; then
        notify-send "错误" "未找到任何主题，请检查 $THEMES_ROOT 目录"
        return 1
      fi

      local selected_theme=$(printf '%s\n' "''${themes_list[@]}" | wofi --dmenu --prompt "选择主题:")

      if [ -n "$selected_theme" ]; then
        apply_theme "$selected_theme"
      fi
    }

    # 主逻辑
    case "''${1:-}" in
      --list)
        get_themes
        ;;
      --current)
        if [ -f "$CURRENT_THEME_FILE" ]; then
          cat "$CURRENT_THEME_FILE"
        else
          echo "无当前主题记录"
        fi
        ;;
      --apply)
        if [ -n "$2" ]; then
          apply_theme "$2"
        else
          echo "错误: 请指定主题名称"
          exit 1
        fi
        ;;
      -h|--help)
        echo "使用方法:"
        echo "  theme-switcher           - 显示主题选择菜单"
        echo "  theme-switcher --list    - 列出所有可用主题"
        echo "  theme-switcher --current - 显示当前主题"
        echo "  theme-switcher --apply <主题名> - 应用指定主题"
        ;;
      *)
        show_menu
        ;;
    esac
  '';
}
