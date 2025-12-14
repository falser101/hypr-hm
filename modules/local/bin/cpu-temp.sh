#!/usr/bin/env bash

# 获取CPU温度（从k10temp模块提取Tctl值）
cpu_temp_raw=$(sensors | grep -A 0 'Package id' | awk '{print $4}')
cpu_temp=$(echo "$cpu_temp_raw" | sed 's/^+//')

# 输出JSON格式
echo "{\"text\": \"$cpu_temp\"}"
