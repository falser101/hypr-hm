{ ... }:

{
  xdg.configFile."wlogout/layout".source = ./layout;
  xdg.configFile."wlogout/style.css".text = ''
    ${builtins.readFile ./themes/macchiato/blue.css}
    ${builtins.readFile ./style.css}
  '';
  xdg.configFile."wlogout/icons".source = ./icons/macchiato/blue;
}
