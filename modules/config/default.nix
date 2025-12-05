{ ... }:

{
  imports = [
    ./fastfetch
    ./kitty
    ./qt5ct
    ./qt6ct
    ./waybar
    ./wlogout
    ./swappy
  ];
  xdg.configFile."dunst/dunstrc".source = ./dunst/dunstrc;
  xdg.configFile."niri".source = ./niri;
}
