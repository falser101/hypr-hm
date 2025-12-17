#!/bin/bash

# 默认音量变化步长
STEP=5

# 获取操作符（+ 或 -）
OP="${1:-+}"

# 检查参数是否合法
if [[ "$OP" != "+" && "$OP" != "-" ]]; then
    echo "Usage: $0 [+] [-]" >&2
    exit 1
fi

# 获取当前音量（百分比）
CURRENT_VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n1)

# 验证当前音量是否为有效数字
if ! [[ "$CURRENT_PROV" =~ ^[0-9]+$ ]]; then
    # 重新检查变量名（修正拼写错误）
    if ! [[ "$CURRENT_VOL" =~ ^[0-9]+$ ]]; then
        echo "Error: Could not read current volume." >&2
        exit 1
    fi
fi

# 计算目标音量
if [[ "$OP" == "+" ]]; then
    TARGET_VOL=$((CURRENT_VOL + STEP))
    [[ $TARGET_VOL -gt 100 ]] && TARGET_VOL=100
elif [[ "$OP" == "-" ]]; then
    TARGET_VOL=$((CURRENT_VOL - STEP))
    [[ $TARGET_VOL -lt 0 ]] && TARGET_VOL=0
fi

# 设置音量
pactl set-sink-volume @DEFAULT_SINK@ "${TARGET_VOL}%"

# 发送通知（通知值应为 0–100 的整数）
notify-send -t 1000 -a 'wp-vol' -h "int:value:${TARGET_VOL}" "Volume: ${TARGET_VOL}%"
