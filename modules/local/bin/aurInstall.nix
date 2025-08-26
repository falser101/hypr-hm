{ pkgs,... }:

with pkgs.lib;

{
  # 声明选项
  options.aurInstall = mkOption {
    type = types.package;
    description = "A script to install AUR packages using paru";
  };
  config.aurInstall = pkgs.writeShellScriptBin "aurInstall" ''
      #!/usr/bin/env bash

      # 检查paru是否已安装
      if ! command -v paru &> /dev/null; then
          echo "错误：未找到paru包管理器，请先安装paru。"
          echo "安装方法：git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si"
          exit 1
      fi

      # 如果没有提供软件包参数，显示帮助信息
      if [ $# -eq 0 ]; then
          echo "用法：aur-install <软件包1> [软件包2] ..."
          echo "功能：检查指定的AUR软件包是否已安装，未安装则自动安装"
          exit 1
      fi

      # 遍历所有传入的软件包
      for pkg in "$@"; do
          # 检查软件包是否已安装（使用paru查询已安装包）
          if paru -Qi "$pkg" &> /dev/null; then
              echo "✅ $pkg 已安装，跳过"
          else
              echo "📦 正在安装 $pkg ..."
              # 使用paru安装软件包（--noconfirm自动确认）
              if paru -S --noconfirm "$pkg"; then
                  echo "✅ $pkg 安装成功"
              else
                  echo "❌ $pkg 安装失败"
                  exit 1
              fi
          fi
      done

      echo "✨ 操作完成"
  '';
}
