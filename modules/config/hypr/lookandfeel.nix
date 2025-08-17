{ ... }:

{
  xdg.configFile."hypr/lookandfeel.conf".text = ''
    #####################
    ### LOOK AND FEEL ###
    #####################

    # 通用窗口设置
    general {
        gaps_in = 5
        gaps_out = 5
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
        resize_on_border = false
        allow_tearing = false
        layout = dwindle
    }

    # 窗口装饰（圆角、透明度、阴影、模糊）
    decoration {
        rounding = 10
        rounding_power = 2
        active_opacity = 1.0
        inactive_opacity = 1.0

        shadow {
            enabled = true
            range = 4
            render_power = 3
            color = rgba(1a1a1aee)
        }

        blur {
            enabled = true
            size = 3
            passes = 1
            vibrancy = 0.1696
        }
    }

    # 动画配置
    $ANIMATION=diablo-2
    $ANIMATION_PATH=./animations/diablo-2.conf
    source = $ANIMATION_PATH

    # Dwindle布局配置
    dwindle {
        pseudotile = true
        preserve_split = true
    }

    # Master布局配置
    master {
        new_status = master
    }

    # 杂项外观设置
    misc {
        force_default_wallpaper = -1
        disable_hyprland_logo = false
    }

    # unscale XWayland
    xwayland {
      force_zero_scaling = true
    }
  '';
}
