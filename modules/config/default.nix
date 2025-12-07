{ ... }:

{
  imports = [
    ./fastfetch
    ./qt5ct
    ./qt6ct
    ./waybar
    ./wlogout
    ./swappy
  ];
  xdg.configFile."dunst/dunstrc".source = ./dunst/dunstrc;
  xdg.configFile."kitty/kitty.conf".source = ./kitty/kitty.conf;
  xdg.configFile."niri".source = ./niri;
  xdg.configFile."hypr".source = ./hypr/Style-2;
}
