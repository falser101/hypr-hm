#!/bin/sh
target="$1"

niri msg windows | awk -v t="$target" '
/^Window ID / {
    if (id && matched) {
        exit  # 已找到，安全退出（理论上不会走到这里）
    }
    id = $3 + 0  # 提取数字（Window ID 29: → $3 是 "29:"，+0 转为 29）
    app = ""
    title = ""
    matched = 0
}
/^[[:space:]]+App ID:/ {
    gsub(/^[[:space:]]+App ID: "/, ""); gsub(/"$/, ""); app = $0
}
/^[[:space:]]+Title:/ {
    gsub(/^[[:space:]]+Title: "/, ""); gsub(/"$/, ""); title = $0
}
# 每读完一个字段就尝试匹配（只对 Feishu 用 title）
app != "" || title != "" {
    if (t == "Feishu" && title == "Feishu") {
        print id; exit
    } else if (t != "Feishu" && app == t) {
        print id; exit
    }
}
'
