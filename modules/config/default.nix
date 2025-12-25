{ ... }:

{
  imports = [
    ./fastfetch
    ./fontconfig
    ./hypr
    ./kitty
    ./Kvantum
    ./mako
    ./niri
    ./qt5ct
    ./qt6ct
    ./rofi
    ./swappy
    ./waybar
    ./wlogout
    ./xdg-desktop-portal
  ];
  xdg.configFile."feishu-flags.conf".source = ./feishu-flags.conf;
}
