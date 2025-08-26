{ config, lib, ... }:

{
  # 定义可配置的选项：AUR软件包列表
  options = {
    aur.packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "需要通过paru安装的AUR软件包列表";
    };
  };

  # 实际配置逻辑
  config = lib.mkIf (config.aur.packages != []) {
    home.activation.installAurPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      script_path="$HOME/.nix-profile/bin/aurInstall"

      # 检查aur-install脚本是否存在
      if command -v "$script_path" &> /dev/null; then
        echo "正在检查并安装AUR软件包..."
        # 执行脚本并传递软件包参数
        "$script_path" ${lib.concatStringsSep " " config.aur.packages}
      else
        echo "警告：$script_path 脚本未找到，跳过AUR软件安装"
      fi
    '';
  };
}
