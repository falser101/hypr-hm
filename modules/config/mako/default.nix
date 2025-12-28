{ ... }:

{
  xdg.configFile."mako/config".source = ./config;
  xdg.configFile."mako/theme.conf".source = ./theme.conf;
  xdg.configFile."mako/theme.conf".force = true;
}
