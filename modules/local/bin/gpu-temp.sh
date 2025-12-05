#!/usr/bin/env bash

# 提取AMD GPU的完整信息块
gpu_info=$(sensors | awk '/amdgpu-pci-c600/,/^$/' | sed '/^$/d')

# 从信息块中提取各参数
vddgfx=$(echo "$gpu_info" | grep "vddgfx" | awk '{print $2 " " $3}')
vddnb=$(echo "$gpu_info" | grep "vddnb" | awk '{print $2 " " $3}')
edge_temp_raw=$(echo "$gpu_info" | grep "edge" | awk '{print $2}')
# 去除温度前面的+号
edge_temp=$(echo "$edge_temp_raw" | sed 's/^+//')
ppt=$(echo "$gpu_info" | grep "PPT" | awk '{print $2 " " $3 " " $4 " " $5 " " $6}')
sclk=$(echo "$gpu_info" | grep "sclk" | awk '{print $2 " " $3}')

# 提取温度数值用于计算百分比（假设最高温度为100°C）
gpu_temp_num=$(echo "$edge_temp" | sed 's/\..*//' | sed 's/[+°C]//g')
gpu_percent=$(( gpu_temp_num * 100 / 100 ))  # 分母为最高温度阈值

# 构建详细tooltip信息
tooltip="GPU 详细信息:\n"
tooltip+="  核心电压: $vddgfx\n"
tooltip+="  北桥电压: $vddnb\n"
tooltip+="  核心温度: $edge_temp\n"
tooltip+="  功耗: $ppt\n"
tooltip+="  核心频率: $sclk"

# 输出JSON格式
echo "{\"text\": \"$edge_temp\", \"tooltip\": \"$tooltip\"}"
