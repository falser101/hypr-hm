#!/bin/bash

# ===================== 配置项（可自定义）=====================
# 壁纸文件夹路径（确保存在，结尾不要加/）
WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
# 切换间隔（单位：秒，示例：300=5分钟，3600=1小时）
INTERVAL=300
# 可选：swww 切换动画（参考：fade/wipe/scale/slide等，留空为默认）
SWWW_TRANSITION="fade"
# 可选：动画时长（秒）
TRANSITION_DURATION=1

# ===================== 核心逻辑 =====================
# 检查壁纸文件夹是否存在
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "错误：壁纸文件夹 $WALLPAPER_DIR 不存在！"
    exit 1
fi

while true; do
    # 步骤1：获取文件夹下所有图片文件（过滤常见图片格式）
    # 支持格式：jpg/jpeg/png/gif/webp/bmp/svg
    WALLPAPER_LIST=($(find "$WALLPAPER_DIR" -type f \( \
        -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o \
        -iname "*.gif" -o -iname "*.webp" -o -iname "*.bmp" -o -iname "*.svg" \
    \) | sort -R))  # sort -R 随机排序

    # 步骤2：容错：若无图片则退出循环
    if [ ${#WALLPAPER_LIST[@]} -eq 0 ]; then
        echo "错误：$WALLPAPER_DIR 中未找到图片文件！"
        exit 1
    fi

    # 步骤3：随机选一张壁纸（取第一个随机项）
    WALLPAPER="${WALLPAPER_LIST[0]}"

    # 步骤4：执行swww切换壁纸
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] 切换壁纸：$WALLPAPER"
    swww img "$WALLPAPER"

    # 步骤5：等待指定间隔后继续
    sleep "$INTERVAL"
done
