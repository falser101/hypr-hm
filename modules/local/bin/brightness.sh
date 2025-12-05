#!/bin/bash
# 显示器亮度控制脚本（ddcutil + dunst OSD）
# 参数支持：get / set [数值] / inc [数值] / dec [数值]

# 配置项
MIN_BRIGHT=10
MAX_BRIGHT=100
VCP_CODE=10  # 亮度 VCP 码（固定为10）
OSD_ICON="display-brightness-high"

# 获取当前亮度
get_brightness() {
    local bright=$(ddcutil getvcp $VCP_CODE | grep -oP 'current value =\s*\K\d+')
    # 容错：若获取失败，默认返回50
    echo ${bright:-50}
}

# 设置亮度（带范围限制）
set_brightness() {
    local target=$1
    # 限制范围
    if [ $target -lt $MIN_BRIGHT ]; then target=$MIN_BRIGHT; fi
    if [ $target -gt $MAX_BRIGHT ]; then target=$MAX_BRIGHT; fi
    # 执行设置
    ddcutil setvcp $VCP_CODE $target >/dev/null 2>&1
    # 显示 OSD
    dunstify -i $OSD_ICON \
        -h int:value:$target \
        -h string:x-dunst-stack-tag:monitor-brightness \
        "显示器亮度" "当前亮度：$target%"
    # 返回最终亮度（用于 Waybar 显示）
    echo $target
}

# 主逻辑
case $1 in
    get)
        get_brightness
        ;;
    set)
        set_brightness $2
        ;;
    inc)
        current=$(get_brightness)
        set_brightness $((current + $2))
        ;;
    dec)
        current=$(get_brightness)
        set_brightness $((current - $2))
        ;;
    *)
        echo "用法：$0 [get/set/inc/dec] [数值（set/inc/dec 时需要）]"
        exit 1
        ;;
esac
