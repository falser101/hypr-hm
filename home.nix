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
    wl-clipboard
    wlogout
    hyprpaper
    hyprpolkitagent
    hypridle
    hyprlock
    hyprpicker
    hyprsunset
    rofi-wayland
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/fish/config.fish" = {
      source = .config/fish/config.fish;
    };

    ".config/fish/user.fish" = {
      source = .config/fish/user.fish;
    };

    ".config/hypr" = {
      source = .config/hypr;
    };

    ".config/kitty" = {
      source = .config/kitty;
    };

    ".local/bin/change-wallpaper" = {
      source = .local/bin/change-wallpaper.sh;  # 脚本相对于home.nix的路径
      executable = true;               # 设为可执行文件
    };
    ".local/bin/dontkillsteam.sh" = {
      source = .local/bin/dontkillsteam.sh;  # 脚本相对于home.nix的路径
      executable = true;               # 设为可执行文件
    };
  };


  home.sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
