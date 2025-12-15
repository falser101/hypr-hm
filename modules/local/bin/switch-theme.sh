#!/usr/bin/env bash
set -e

# ===================== 核心配置（按需修改）=====================
# 1. 主题文件存放目录（xdg.dataFile 部署的路径，固定为 ~/.local/share/themes）
THEME_ROOT="$HOME/.local/share/nide/themes/"
# 2. 支持的应用列表（key=应用名，value=配置文件路径+重载命令）
declare -A APPS=(
  ["kitty"]="${HOME}/.config/kitty/theme.conf|kitty @ load-config"
  ["dunst"]="${HOME}/.config/dunst/dunstrc|pkill -x dunst || dunst &"
  ["waybar"]="${HOME}/.config/waybar/theme.css|pkill waybar || waybar &"
  ["rofi"]="${HOME}/.config/rofi/theme.rasi|pkill rofi"
)
# 3. 默认主题（首次运行用）
DEFAULT_THEME="frappe"

# ===================== 辅助函数 =====================
# 函数：列出所有可用主题（包含至少一个应用配置的目录）
list_themes() {
  [ ! -d "$THEME_ROOT" ] && return
  while IFS= read -r -d '' dir; do
    theme_name=$(basename "$dir")
    if find "$dir" -maxdepth 2 -type f \( -name "*.conf" -o -name "*.toml" \) | grep -q .; then
      printf '%s\n' "$theme_name"
    fi
  done < <(find "$THEME_ROOT" -mindepth 1 -maxdepth 1 -type d -print0)
}

# 函数：列出指定主题下的可用应用
list_apps_in_theme() {
  local theme="$1"
  local theme_dir="$THEME_ROOT/$theme"
  for app in "${!APPS[@]}"; do
    local app_conf_path="${APPS[$app]%%|*}"
    local target_file=$(basename "$app_conf_path")
    if [[ -f "$theme_dir/$target_file" ]] || [[ -f "$theme_dir/$app/$target_file" ]]; then
      printf '%s\n' "$app"
    fi
  done
}

# ===================== 主逻辑 =====================
# 1. 检查主题根目录是否存在
if [ ! -d "$THEME_ROOT" ]; then
  rofi -e "错误：主题目录不存在！\n路径：$THEME_ROOT\n请先执行 home-manager switch"
  exit 1
fi

# 2. 列出所有可用主题并通过 Rofi 选择
mapfile -t THEMES < <(list_themes)
if [ ${#THEMES[@]} -eq 0 ]; then
  rofi -e "错误：未找到任何可用主题！请检查 $THEME_ROOT 目录"
  exit 1
fi

SELECTED_THEME=$(printf "%s\n" "${THEMES[@]}" | rofi -dmenu \
  -p "选择主题 [默认: $DEFAULT_THEME]" \
  -theme-str 'window {width: 350px;} element {padding: 8px; font: "Noto Sans CJK SC 14";}')

# 取消选择则用默认主题
[ -z "$SELECTED_THEME" ] && SELECTED_THEME="$DEFAULT_THEME"

# 3. 列出该主题下的可用应用并选择
mapfile -t APPS_IN_THEME < <(list_apps_in_theme "$SELECTED_THEME")
if [ ${#APPS_IN_THEME[@]} -eq 0 ]; then
  rofi -e "错误：主题 $SELECTED_THEME 下无可用应用配置！"
  exit 1
fi

SELECTED_APP=$(printf "%s\n" "${APPS_IN_THEME[@]}" | rofi -dmenu \
  -p "选择要切换的应用（主题：$SELECTED_THEME）" \
  -theme-str 'window {width: 350px;} element {padding: 8px; font: "Noto Sans CJK SC 14";}')

[ -z "$SELECTED_APP" ] && exit 0

# 4. 解析应用的配置路径和重载命令
APP_CONF_PATH=$(echo "${APPS[$SELECTED_APP]}" | cut -d'|' -f1)
APP_RELOAD_CMD=$(echo "${APPS[$SELECTED_APP]}" | cut -d'|' -f2)
THEME_APP_CONF="${THEME_ROOT}/${SELECTED_THEME}/${SELECTED_APP}/$(basename "$APP_CONF_PATH")"

# 5. 验证主题配置文件是否存在
if [ ! -f "$THEME_APP_CONF" ]; then
  rofi -e "错误：主题 $SELECTED_THEME 缺少 $SELECTED_APP 配置！\n路径：$THEME_APP_CONF"
  exit 1
fi

# 6. 替换应用配置文件（直接覆盖）
echo "切换 $SELECTED_APP 配置到主题 $SELECTED_THEME..."
mkdir -p "$(dirname "$APP_CONF_PATH")"
cp -f "$THEME_APP_CONF" "$APP_CONF_PATH"

# 7. 热重载应用配置（失败则忽略，不影响结果）
if command -v $(echo "$APP_RELOAD_CMD" | cut -d' ' -f1) &>/dev/null; then
  eval "$APP_RELOAD_CMD" 2>/dev/null || true
fi

# 8. 提示切换成功
rofi -e "✅ 切换完成！
主题：$SELECTED_THEME
应用：$SELECTED_APP
配置文件：$APP_CONF_PATH"
