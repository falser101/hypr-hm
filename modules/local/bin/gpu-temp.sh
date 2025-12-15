#!/usr/bin/env bash

get_gpu_temp() {
    # 1. NVIDIA (闭源驱动) — 最可靠方式
    if command -v nvidia-smi >/dev/null 2>&1; then
        temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
        if [[ -n "$temp" && "$temp" =~ ^[0-9]+$ ]]; then
            echo "$temp"
            return 0
        fi
    fi

    # 2. 从 sensors 中提取
    sensors_out=$(sensors 2>/dev/null)

    # 2a. AMD GPU: amdgpu-pci-* -> edge
    if echo "$sensors_out" | grep -q 'amdgpu-pci-'; then
        temp=$(echo "$sensors_out" | grep -A5 'amdgpu-pci-' | grep 'edge:' | head -n1 | awk '{print $2}' | sed 's/[^0-9.]//g')
        if [[ -n "$temp" ]]; then
            echo "$temp"
            return 0
        fi
    fi

    # 2b. NVIDIA (开源驱动 nouveau): nouveau-* -> temp1
    if echo "$sensors_out" | grep -q 'nouveau'; then
        temp=$(echo "$sensors_out" | grep -A3 'nouveau' | grep 'temp1:' | head -n1 | awk '{print $2}' | sed 's/[^0-9.]//g')
        if [[ -n "$temp" ]]; then
            echo "$temp"
            return 0
        fi
    fi

    # 2c. Intel 核显: i915-pci-* (部分新内核支持)
    if echo "$sensors_out" | grep -q 'i915'; then
        temp=$(echo "$sensors_out" | grep -A3 'i915' | grep 'temp1:' | head -n1 | awk '{print $2}' | sed 's/[^0-9.]//g')
        if [[ -n "$temp" ]]; then
            echo "$temp"
            return 0
        fi
    fi

    # 3. 从 /sys/class/drm 尝试（适用于 Intel / AMD 开源驱动）
    for hwmon in /sys/class/drm/card?/device/hwmon/hwmon*/temp1_input; do
        if [[ -f "$hwmon" ]]; then
            temp_raw=$(cat "$hwmon" 2>/dev/null)
            if [[ "$temp_raw" =~ ^[0-9]+$ ]]; then
                temp=$((temp_raw / 1000))
                echo "$temp"
                return 0
            fi
        fi
    done

    # 4. 兜底：NVMe 或其他（但通常不是 GPU）
    echo "N/A"
    return 1
}

gpu_temp=$(get_gpu_temp)

# 输出 JSON
printf '{"text": "%s°C"}\n' "$gpu_temp"
