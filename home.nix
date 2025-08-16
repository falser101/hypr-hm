{ config, pkgs, lib, ... }:

let
  aurPackages = [
    "hyprland"
    "hyprlock"
  ];
in
{
  imports = [
      ./modules/config
      ./modules/local
      ./modules/aur-install.nix
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

  aur.packages = [
    "hyprland"
    "hyprlock"

    "com.qq.weixin.work.deepin"
    "zed"
    "zen-browser-bin"
    "visual-studio-code-bin"
    "postman-bin"
    "feishu-bin"
    "linuxqq"
    "clash-verge-rev-bin"
    "jetbrains-toolbox"
    "onlyoffice-bin"

    "linyaps"
    "vim"
    "kitty"
    # 打印机
    "cups"
    "jdk17-openjdk"
    "jdk21-openjdk"
    "jdk8-openjdk"
    "htop"

    "fcitx5"
    "fcitx5-rime"
    "fcitx5-configtool"
    "fcitx5-gtk"
    "fcitx5-qt"

    "wqy-microhei"
    "wqy-zenhei"
  ];

  programs.home-manager.enable = true;
}
