{ config, pkgs, ... }:

{
  imports = [
      ./modules/config
      ./modules/local
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "falser";
  home.homeDirectory = "/home/falser";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # 字体
    jetbrains-mono

    # hyprland
    hyprpaper
    hyprpolkitagent
    hypridle
    hyprpicker
    hyprsunset

    # Window Manager
    wlogout
    waybar
    dunst
    wofi
    swappy
    grim
    slurp
    cliphist
    wl-clip-persist

    # shell
    fastfetch
    imagemagick

    noto-fonts-emoji
  ];

  home.sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
  };

  programs.home-manager.enable = true;
}
