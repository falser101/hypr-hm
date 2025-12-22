{ ... }:

{
  imports = [
    ./fastfetch
    ./fontconfig
    ./hypr
    ./kitty
    ./Kvantum
    ./qt5ct
    ./qt6ct
    ./waybar
    ./wlogout
    ./swappy
    ./niri
    ./rofi
    ./mako
  ];
  xdg.configFile."feishu-flags.conf".source = ./feishu-flags.conf;
}
