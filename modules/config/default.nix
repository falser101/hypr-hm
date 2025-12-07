{ ... }:

{
  imports = [
    ./fastfetch
    ./qt6ct
    ./waybar
    ./wlogout
    ./swappy
  ];
  xdg.configFile."kitty/kitty.conf".source = ./kitty/kitty.conf;
  xdg.configFile."qt5ct/colors.conf".source = ./qt5ct/colors.conf;
  xdg.configFile."qt5ct/qt5ct.conf".source = ./qt5ct/qt5ct.conf;
  xdg.configFile."niri".source = ./niri;
  xdg.configFile."hypr".source = ./hypr/Style-2;
}
