{ pkgs, ... }:

with pkgs.lib;
{
  # 声明选项
  options.cpu-temp = mkOption {
    type = types.package;
    description = "A script to get cpu temp using sensors";
  };
  config.cpu-temp = pkgs.writeShellScriptBin "cpu-temp" ''
    #!/usr/bin/env bash

    # 获取CPU温度（从k10temp模块提取Tctl值）
    cpu_temp_raw=$(sensors | grep -A 0 'Tctl' | awk '{print $2}')
    cpu_temp=$(echo "$cpu_temp_raw" | sed 's/^+//')
    # 获取详细温度信息（用于悬停提示）
    cpu_details=$(sensors | grep -A 0 'k10temp-pci-00c3\|Tctl' | sed 's/Adapter:.*//; /^$/d')

    # 输出JSON格式
    echo "{\"text\": \"$cpu_temp\"}"
  '';
}
