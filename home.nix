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
    waybar
    dunst
    swww
    rofi
    nixd
    nil
  ];

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  home.sessionVariables = {
    PATH = "$HOME/.local/bin:$PATH";
  };

  aur.packages = [
    "sddm-astronaut-theme"
    "kitty"

    "com.qq.weixin.work.deepin"
    "zed"
    "zen-browser-bin"
    "visual-studio-code-bin"
    "feishu-bin"
    "jetbrains-toolbox"
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
  ];

  services.hyprpolkitagent.enable = true;

  programs.home-manager.enable = true;
}
