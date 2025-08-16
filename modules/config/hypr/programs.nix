{ config, pkgs, ... }:

{
  xdg.configFile."hypr/programs.conf".text = ''
    ###################
    ### MY PROGRAMS ###
    ###################

    # 定义常用程序变量（供快捷键和自启动使用）
    $terminal = kitty
    $fileManager = dolphin
    $menu = wofi --show drun --allow-images true --icon-size 24
  '';
}
