#!/usr/bin/env bash

# 尝试获取 CPU 温度，自动适配 Intel 和 AMD

# 判断 CPU 厂商（从 /proc/cpuinfo）
vendor=$(grep -m1 'vendor_id\|AuthenticAMD' /proc/cpuinfo | awk '{print $3}')

# 获取 sensors 输出
sensors_out=$(sensors 2>/dev/null)

cpu_temp=""

if [[ "$vendor" == "GenuineIntel" ]]; then
    # Intel: 通常使用 "Package id 0" 的温度
    cpu_temp=$(echo "$sensors_out" | grep 'Package id 0:' | awk '{print $4}' | sed 's/[+°C]//g')
elif [[ "$vendor" == "AuthenticAMD" ]]; then
    # AMD: 优先使用 Tdie（真实温度），若无则用 Tctl
    if echo "$sensors_out" | grep -q 'Tdie'; then
        cpu_temp=$(echo "$sensors_out" | grep 'Tdie' | awk '{print $2}' | sed 's/[+°C]//g')
    else
        cpu_temp=$(echo "$sensors_out" | grep 'Tctl' | awk '{print $2}' | sed 's/[+°C]//g')
    fi
fi

# 如果上面没取到，尝试兜底：找任意含 "Core" 或 "Package" 的第一行温度
if [[ -z "$cpu_temp" || ! "$cpu_temp" =~ ^[0-9]+\.?[0-9]*$ ]]; then
    cpu_temp=$(echo "$sensors_out" | grep -E 'Core [0-9]+:|Package id [0-9]+:' | head -n1 | awk '{print $NF}' | sed 's/[^0-9.]//g')
fi

# 如果还是空，设为 N/A
if [[ -z "$cpu_temp" ]]; then
    cpu_temp="N/A"
fi

# 输出 JSON
printf '{"text": "%s°C"}\n' "$cpu_temp"
