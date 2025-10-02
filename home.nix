{ pkgs, ... }:

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

    hypridle
    hyprpicker
    hyprsunset
    hyprpolkitagent

    bluez
    blueman
    pwvucontrol

    # Window Manager
    wlogout
    waybar
    dunst
    wofi
    swappy
    swww
    grim
    slurp
    cliphist
    wl-clipboard
    pavucontrol
    networkmanagerapplet
    htop
    # 硬件监控模块
    lm_sensors

    # shell
    fastfetch
    imagemagick
    nixd
    nil
    kdePackages.dolphin
    kdePackages.konsole
    qq

    noto-fonts-emoji
    wqy_microhei
    wqy_zenhei
  ];

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  home.sessionVariables = {
    PATH = "$HOME/.local/bin:$PATH";
  };

  aur.packages = [
    "hyprland"
    "hyprlock"
    "sddm-astronaut-theme"
    "kitty"

    "com.qq.weixin.work.deepin"
    "zed"
    "zen-browser-bin"
    "visual-studio-code-bin"
    "postman-bin"
    "feishu-bin"
    "clash-verge-rev-bin"
    "jetbrains-toolbox"
    "onlyoffice-bin"
    "localsend"

    "linyaps"
    "vim"
    # 打印机
    "cups"
    "jdk17-openjdk"
    "jdk21-openjdk"
    "jdk8-openjdk"
    # firefox 语音合成
    "speech-dispatcher"

    "fcitx5"
    "fcitx5-rime"
    "fcitx5-configtool"
    "fcitx5-gtk"
    "fcitx5-qt"

    # waybar Electron apps tray
    "libappindicator-gtk3"
    "libappindicator-gtk2"
  ];

  services.hyprpolkitagent.enable = true;

  programs.home-manager.enable = true;
}
