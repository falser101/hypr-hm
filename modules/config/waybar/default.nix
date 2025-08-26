{ ... }:

{
  xdg.configFile."waybar/modules".source = ./modules;
  xdg.configFile."waybar/groups".source = ./groups;
  xdg.configFile."waybar/includes".source = ./includes;
  xdg.configFile."waybar/menus".source = ./menus;
  xdg.configFile."waybar/style.css".source = ./style.css;
  # xdg.configFile."waybar/theme.css".source = ./theme.css;
  xdg.configFile."waybar/config.jsonc".source = ./config.jsonc;
}
