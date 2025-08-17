{ ... }:

{
  imports = [
    ./config.nix
    ./style.nix
    ./theme.nix
  ];

  xdg.configFile."waybar/modules".source = ./modules;

}
