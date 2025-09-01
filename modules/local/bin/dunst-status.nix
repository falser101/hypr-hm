{ pkgs, ... }:

with pkgs.lib;
{
  # 声明选项
  options.dunst-status = mkOption {
    type = types.package;
    description = "dunst-status";
  };
  config.dunst-status = pkgs.writeShellScriptBin "dunst-status" ''
    #!/usr/bin/env bash

    # 获取等待的通知数量，出错时默认返回0
    count=$(dunstctl count history 2>/dev/null || echo 0)

    # 获取DnD状态，出错时默认返回none
    state=$(dunstctl is-paused 2>/dev/null | sed "s/true/dnd/; s/false/none/")
    if [ -z "$state" ]; then
        state="none"
    fi

    # 确定要显示的图标状态
    if [ "$count" -gt 0 ] && [ "$state" != "dnd" ]; then
        icon_state="notification"
    else
        icon_state="$state"
    fi

    # 输出JSON格式数据
    echo "{\"text\": $count, \"alt\": \"$icon_state\"}"
  '';
}
