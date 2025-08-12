{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "falser";
  home.homeDirectory = "/home/falser";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # 字体
    jetbrains-mono
    waybar
    dunst
    cliphist
    hyprpaper
    wlogout
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/hypr" = {
      source = .config/hypr;
    };

    ".local/bin/change-wallpaper" = {
      source = ./change-wallpaper.sh;  # 脚本相对于home.nix的路径
      executable = true;               # 设为可执行文件
    };
  };


  home.sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
