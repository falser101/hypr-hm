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

    # hyprland
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

    dbeaver-bin
    qq

    noto-fonts-emoji
    wqy_microhei
    wqy_zenhei
  ];

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
  ];

  services.hyprpolkitagent.enable = true;

  programs.home-manager.enable = true;
}
