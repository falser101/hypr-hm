{...}:

{
  imports = [
    ./Code
    ./dunst
    ./fastfetch
    ./hypr
    ./kitty
    ./qt5ct
    ./qt6ct
    ./waybar
    ./wofi
    ./wlogout
    ./swappy
  ];
  xdg.configFile."dolphinrc".source = ./dolphinrc;
}
