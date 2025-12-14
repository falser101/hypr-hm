#!/usr/bin/env bash

# 提取AMD GPU的完整信息块
gpu_info=$(sensors | awk '/amdgpu-pci-0300/,/^$/' | sed '/^$/d')
edge_temp_raw=$(echo "$gpu_info" | grep "edge" | awk '{print $2}')
# 去除温度前面的+号
edge_temp=$(echo "$edge_temp_raw" | sed 's/^+//')

# 输出JSON格式
echo "{\"text\": \"$edge_temp\"}"
