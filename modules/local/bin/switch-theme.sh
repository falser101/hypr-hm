#!/usr/bin/env bash
set -e

# ===================== 核心配置（按需修改）=====================
THEME_ROOT="$HOME/.local/share/nide/themes/"
declare -A APPS=(
  ["kitty"]="${HOME}/.config/kitty/theme.conf|kitty @ load-config"
  ["mako"]="${HOME}/.config/mako/theme.conf|makoctl reload"
  ["waybar"]="${HOME}/.config/waybar/theme.css|pkill waybar && waybar &"
  ["rofi"]="${HOME}/.config/rofi/theme.rasi|pkill rofi"
)
DEFAULT_THEME="frappe"

# ===================== 辅助函数 =====================
list_themes() {
  [ ! -d "$THEME_ROOT" ] && return
  while IFS= read -r -d '' dir; do
    theme_name=$(basename "$dir")
    if find "$dir" -maxdepth 2 -type f \( -name "*.conf" -o -name "*.toml" -o -name "*.css" -o -name "*.rasi" \) | grep -q .; then
      printf '%s\n' "$theme_name"
    fi
  done < <(find "$THEME_ROOT" -mindepth 1 -maxdepth 1 -type d -print0)
}

# ===================== 主逻辑 =====================
if [ ! -d "$THEME_ROOT" ]; then
  notify-send -u critical -a "Theme Switcher" "错误：主题目录不存在！" "路径：$THEME_ROOT"
  exit 1
fi

mapfile -t THEMES < <(list_themes)
if [ ${#THEMES[@]} -eq 0 ]; then
  notify-send -u critical -a "Theme Switcher" "错误：未找到任何可用主题！" "请检查 $THEME_ROOT 目录"
  exit 1
fi

SELECTED_THEME=$(printf "%s\n" "${THEMES[@]}" | rofi -config ~/.config/rofi/selector.rasi \
  -dmenu \
  -p "选择主题 [默认: $DEFAULT_THEME]")

# 取消选择则用默认主题
[ -z "$SELECTED_THEME" ] && SELECTED_THEME="$DEFAULT_THEME"

applied_apps=()
failed_apps=()

for app in "${!APPS[@]}"; do
  APP_CONF_PATH=$(echo "${APPS[$app]}" | cut -d'|' -f1)
  APP_RELOAD_CMD=$(echo "${APPS[$app]}" | cut -d'|' -f2)
  TARGET_FILE=$(basename "$APP_CONF_PATH")

  THEME_APP_CONF1="$THEME_ROOT/$SELECTED_THEME/$app/$TARGET_FILE"
  THEME_APP_CONF2="$THEME_ROOT/$SELECTED_THEME/$TARGET_FILE"

  if [[ -f "$THEME_APP_CONF1" ]]; then
    SRC_CONF="$THEME_APP_CONF1"
  elif [[ -f "$THEME_APP_CONF2" ]]; then
    SRC_CONF="$THEME_APP_CONF2"
  else
    continue
  fi

  mkdir -p "$(dirname "$APP_CONF_PATH")"
  if cp -f "$SRC_CONF" "$APP_CONF_PATH"; then
    applied_apps+=("$app")
    if command -v $(echo "$APP_RELOAD_CMD" | awk '{print $1}') &>/dev/null; then
      (eval "$APP_RELOAD_CMD" 2>/dev/null) || true &
    fi
  else
    failed_apps+=("$app")
  fi
done

# ========== 使用 notify-send 发送通知 ==========
summary="主题已切换：$SELECTED_THEME"
body=""

if [ ${#applied_apps[@]} -gt 0 ]; then
  body+="✅ 应用：$(printf '%s ' "${applied_apps[@]}")\n"
fi

if [ ${#failed_apps[@]} -gt 0 ]; then
  body+="❌ 失败：$(printf '%s ' "${failed_apps[@]}")\n"
fi

if [ ${#applied_apps[@]} -eq 0 ] && [ ${#failed_apps[@]} -eq 0 ]; then
  body="⚠️ 未找到匹配的配置文件。\n支持应用：$(printf '%s ' "${!APPS[@]}")"
fi

# 发送通知（-t 3000 = 3秒，可根据需要调整）
notify-send -a "Theme Switcher" -t 3000 "$summary" "$body"
