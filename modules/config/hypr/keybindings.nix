{ ... }:

{
  xdg.configFile."hypr/keybindings.conf".text = ''
    ###################
    ### KEYBINDINGS ###
    ###################

    $mainMod = SUPER # 主修饰键（Windows键）

    # 截图
    bind = $mainMod, P, exec, pkill slurp || grim -g "$(slurp)" - | swappy -f -

    # 切換壁紙
    bind = $mainMod SHIFT, W, exec, hyprpaper.sh

    # 粘貼板
    bind = $mainMod, V, exec, pkill wofi || cliphist list | wofi --style ~/.config/wofi/style.css --dmenu | cliphist decode | wl-copy

    # 基础操作
    bind = $mainMod, T, exec, $terminal
    bind = $mainMod, Q, killactive,
    bind = $mainMod, Delete, exit,
    bind = $mainMod, E, exec, $fileManager
    bind = $mainMod, W, togglefloating,
    bind = $mainMod, A, exec, pkill wofi || $menu
    bind = $mainMod, P, pseudo, # dwindle布局伪平铺
    bind = $mainMod, J, togglesplit, # dwindle布局拆分切换

    # 窗口焦点移动
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # 工作区切换
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # 移动窗口到工作区
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # 特殊工作区（暂存区）
    bind = $mainMod, S, togglespecialworkspace, magic
    bind = $mainMod SHIFT, S, movetoworkspace, special:magic

    # 鼠标滚轮切换工作区
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # 鼠标拖动窗口
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    # 多媒体快捷键（音量、亮度）
    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

    # 媒体播放控制（需playerctl）
    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous
  '';
}
