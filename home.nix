{ pkgs, ... }:

{
  imports = [
    ./modules/config
    ./modules/local
    ./modules/aur-install.nix
    ./modules/theme.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "falser";
  home.homeDirectory = "/home/falser";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [

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
    "waybar"
    "wlogout"
    "dunst"
    "swww"
    "rofi"
    "otf-font-awesome"
    "wl-clipboard"
    "cliphist"
    "unzip"
    "slurp"
    "grim"
    "swappy"
    "blueman"
    "ttf-nerd-fonts-symbols-mono"
    "ttf-nerd-fonts-symbols"
    "ttf-jetbrains-mono-nerd"
    "network-manager-applet-git"
    "libayatana-appindicator-glib"
    "zed"
    "zen-browser"
    "visual-studio-code-bin"
    "feishu-bin"
    "linuxqq"
    "localsend"

    "linyaps"
    "vim"
    "btop"
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

  programs.home-manager.enable = true;
}
