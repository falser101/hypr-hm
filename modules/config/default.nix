{ ... }:

{
  imports = [
    ./fastfetch
    ./qt6ct
    ./waybar
    ./wlogout
    ./swappy
  ];
  xdg.configFile."fontconfig/fonts.conf".source = ./fontconfig/fonts.conf;
  xdg.configFile."kitty/kitty.conf".source = ./kitty/kitty.conf;
  xdg.configFile."qt5ct/colors.conf".source = ./qt5ct/colors.conf;
  xdg.configFile."qt5ct/qt5ct.conf".source = ./qt5ct/qt5ct.conf;
  xdg.configFile."niri".source = ./niri;
  xdg.configFile."hypr".source = ./hypr/Style-2;
  xdg.configFile."rofi/clipboard.rasi".source = ./rofi/clipboard.rasi;
  xdg.configFile."rofi/notify.rasi".source = ./rofi/notify.rasi;
  xdg.configFile."xdg-desktop-portal/niri-portals.conf".source = ./xdg-desktop-portal/niri-portals.conf;
}
