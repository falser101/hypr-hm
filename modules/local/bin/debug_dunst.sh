#!/bin/bash
# ~/bin/debug_dunst.sh
# 记录 Dunst 通知的所有可用环境变量

LOG_FILE="${HOME}/dunst-debug.log"

log() {
    echo "$1" >> "$LOG_FILE"
}

{
    echo "=== New Notification @ $(date -Is) ==="

    # 核心字段（来自官方文档）
    log "DUNST_APP_NAME:     ${DUNST_APP_NAME:-<empty>}"
    NIRI_WINDOW=find_niri_window --app-id $DUNST_APP_NAME
    log "DUNST_SUMMARY:      ${DUNST_SUMMARY:-<empty>}"
    log "DUNST_BODY:         ${DUNST_BODY:-<empty>}"
    log "DUNST_ICON_PATH:    ${DUNST_ICON_PATH:-<empty>}"
    log "DUNST_URGENCY:      ${DUNST_URGENCY:-<empty>}"        # "LOW", "NORMAL", or "CRITICAL"
    log "DUNST_ID:           ${DUNST_ID:-<empty>}"            # 通知唯一 ID
    log "DUNST_PROGRESS:     ${DUNST_PROGRESS:-<empty>}"       # 进度百分比（0-100，若支持）
    log "DUNST_CATEGORY:     ${DUNST_CATEGORY:-<empty>}"
    log "DUNST_STACK_TAG:    ${DUNST_STACK_TAG:-<empty>}"
    log "DUNST_URLS:         ${DUNST_URLS:-<empty>}"          # 换行分隔的 URL 列表
    log "DUNST_TIMEOUT:      ${DUNST_TIMEOUT:-<empty>}"        # 超时（毫秒）
    log "DUNST_TIMESTAMP:    ${DUNST_TIMESTAMP:-<empty>}"      # Unix 时间戳（秒）
    log "DUNST_DESKTOP_ENTRY:${DUNST_DESKTOP_ENTRY:-<empty>}" # .desktop 文件名（如 feishu.desktop）
    log "Niri Window:
    echo ""  # 空行分隔
} >> "$LOG_FILE"

# 可选：限制日志大小（防止无限增长）
# head -n -100 "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
