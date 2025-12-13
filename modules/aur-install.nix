{ config, lib, ... }:

{
  # 定义可配置的选项：AUR软件包列表
  options = {
    aur.packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "需要通过paru安装的AUR软件包列表";
    };
  };

  # 实际配置逻辑
  config = lib.mkIf (config.aur.packages != [ ]) {
    home.activation.installAurPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      script_path="${config.home.homeDirectory}/.local/bin/aurInstall"

      # 检查脚本是否存在且可执行
      if [ -x "$script_path" ]; then
        echo "正在检查并安装AUR软件包..."
        # 关键：用printf转义参数，支持含空格/特殊字符的包名
        "$script_path" $(printf '%q ' ${lib.escapeShellArgs config.aur.packages})
      else
        echo "警告：$script_path 脚本未找到或不可执行，跳过AUR软件安装"
      fi
    '';
  };
}
