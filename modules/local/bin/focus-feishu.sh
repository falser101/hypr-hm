#!/bin/sh
# ~/.local/bin/focus-or-start-feishu.sh

# 查找 Feishu 窗口 ID（使用你已有的脚本）
wid=$(find_niri_window Feishu)

if [ -n "$wid" ]; then
    # 聚焦窗口
    niri msg action focus-window --id "$wid"
fi
