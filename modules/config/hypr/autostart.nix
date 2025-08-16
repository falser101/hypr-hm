{ config, pkgs, ... }:

{
  xdg.configFile."hypr/autostart.conf".text = ''
    #################
    ### AUTOSTART ###
    #################

    # 启动时自动运行的程序（取消注释启用）
    # exec-once = $terminal
    # exec-once = nm-applet &
    exec-once = waybar & hyprpaper & dunst & hyprpolkitagent
    exec-once = echo 'Xft.dpi: 120' | xrdb -merge
    exec-once = ~/.local/bin/xdph.sh
    exec-once = wl-paste --type text --watch cliphist store # Stores only text data
    exec-once = wl-paste --type image --watch cliphist store # Stores only image data
  '';
}
