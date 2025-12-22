#!/bin/bash
# 显示器亮度控制脚本（适配 Waybar JSON 输出 + ddcutil + dunst OSD）
# 参数支持：get / set [数值] / inc [数值] / dec [数值]
# Waybar 适配：返回 {"percentage": 亮度值} 格式的 JSON

# ===================== 配置项 =====================
MIN_BRIGHT=10          # 最小亮度（防止黑屏）
MAX_BRIGHT=100         # 最大亮度
VCP_CODE=10            # 亮度 VCP 码（通用值，无需修改）
OSD_ICON="display-brightness-high"  # dunst 通知图标
DDCUTIL_CMD="ddcutil"  # ddcutil 路径（若不在PATH需写绝对路径）
# ==================================================

# 容错：检查 ddcutil 是否存在
if ! command -v $DDCUTIL_CMD &> /dev/null; then
    echo '{"percentage": 50}'  # 兜底返回50%
    exit 1
fi

# 容错：检查 ddcutil 权限（普通用户可能需要 sudo）
# 可选：给 ddcutil 添加 setuid 权限，避免每次输密码：sudo chmod u+s $(which ddcutil)
check_ddcutil_permission() {
    if ! $DDCUTIL_CMD detect &> /dev/null; then
        # 尝试用 sudo 执行（若配置了免密 sudo，可去掉密码提示）
        DDCUTIL_CMD="sudo $DDCUTIL_CMD"
    fi
}

# 获取当前亮度（返回数值，适配 JSON 输出）
get_brightness() {
    check_ddcutil_permission
    # 提取 ddcutil 返回的当前亮度值（容错：失败返回50）
    local bright=$($DDCUTIL_CMD getvcp $VCP_CODE 2>/dev/null | grep -oP 'current value =\s*\K\d+')
    echo ${bright:-50}
}

# 设置亮度（带范围限制 + OSD 提示）
set_brightness() {
    local target=$1
    # 限制亮度范围
    if [ $target -lt $MIN_BRIGHT ]; then target=$MIN_BRIGHT; fi
    if [ $target -gt $MAX_BRIGHT ]; then target=$MAX_BRIGHT; fi

    # 执行亮度设置
    check_ddcutil_permission
    $DDCUTIL_CMD setvcp $VCP_CODE $target >/dev/null 2>&1

    # 显示 dunst OSD 提示（堆叠式通知，避免刷屏）
    notify-send -i $OSD_ICON \
        -t 1000 \
        -a 'osd' \
        -h int:value:$target \
        -h string:x-dunst-stack-tag:monitor-brightness \
        "显示器亮度" "当前亮度：$target%"

    # 返回最终亮度（用于 Waybar 输出）
    echo $target
}

# 主逻辑：处理参数 + 输出 Waybar 所需的 JSON
case $1 in
    get)
        # 核心：输出 JSON 格式（Waybar 读取 percentage 字段）
        current=$(get_brightness)  # 移除local，函数外不能用local
        echo "{\"percentage\": $current}"
        ;;
    set)
        # 设置指定亮度，输出 JSON
        if [ -z "$2" ] || ! [[ "$2" =~ ^[0-9]+$ ]]; then
            echo '{"percentage": 50}'  # 参数非法时兜底
            exit 1
        fi
        new_bright=$(set_brightness $2)  # 移除local
        echo "{\"percentage\": $new_bright}"
        ;;
    inc)
        # 增加亮度，输出 JSON
        if [ -z "$2" ] || ! [[ "$2" =~ ^[0-9]+$ ]]; then
            current=$(get_brightness)
            echo "{\"percentage\": $current}"
            exit 1
        fi
        current=$(get_brightness)  # 移除local
        new_bright=$(set_brightness $((current + $2)))  # 移除local
        echo "{\"percentage\": $new_bright}"
        ;;
    dec)
        # 降低亮度，输出 JSON
        if [ -z "$2" ] || ! [[ "$2" =~ ^[0-9]+$ ]]; then
            current=$(get_brightness)
            echo "{\"percentage\": $current}"
            exit 1
        fi
        current=$(get_brightness)  # 移除local
        new_bright=$(set_brightness $((current - $2)))  # 移除local
        echo "{\"percentage\": $new_bright}"
        ;;
    *)
        # 参数错误时兜底输出 JSON
        echo '{"percentage": 50}'
        echo "用法：$0 [get/set/inc/dec] [数值（set/inc/dec 时需要）]" >&2
        exit 1
        ;;
esac
