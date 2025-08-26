{ config, ... }:

{
  # 导入所有脚本模块（每个模块定义了一个常量）
    imports = [
      ./hyprpaper.nix
      ./aurInstall.nix
      ./xdph.nix
      ./themes.nix
    ];

    # 将脚本常量添加到 home.packages
    home.packages = [
      # 引用模块中定义的常量
      config.hyprpaper-switch  # 来自 hyprpaper-switch.nix
      config.aurInstall       # 来自 aur-install.nix
      config.xdph      # 来自 xdph.nix
      config.theme-switcher  # 来自 themes.nix
    ];

}
