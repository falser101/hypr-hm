{ ... }:

{
  imports = [
    ./config.nix
    ./style.nix
    ./theme.nix
  ];

  xdg.configFile."waybar/modules".source = ./modules;
  xdg.configFile."waybar/groups".source = ./groups;
  xdg.configFile."waybar/includes".source = ./includes;

}
