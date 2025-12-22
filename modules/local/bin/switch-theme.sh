#!/usr/bin/env bash
set -e

# ===================== 核心配置（按需修改）=====================
THEME_ROOT="$HOME/.local/share/nide/themes/"
declare -A APPS=(
  ["kitty"]="${HOME}/.config/kitty/theme.conf|kitty @ load-config"
  ["mako"]="${HOME}/.config/mako/theme.conf|makoctl reload"
  ["waybar"]="${HOME}/.config/waybar/theme.css|pkill waybar && waybar &"
  ["rofi"]="${HOME}/.config/rofi/theme.rasi|pkill rofi"
  ["dolphin"]="${HOME}/.config/dolphinrc|"
  ["qt5ct"]="${HOME}/.config/qt5ct/colors.conf|"
  ["qt6ct"]="${HOME}/.config/qt6ct/colors.conf|"
  ["Kvantum"]="${HOME}/.config/Kvantum/kvantum.kvconfig|"
)
DEFAULT_THEME="frappe"
# 新增：gsettings配置文件路径（主题目录下的gsettings/config）
GSETTINGS_CONF="${THEME_ROOT}/{THEME_NAME}/gsettings/config"
# 新增：默认值兜底（无配置时使用）
declare -A DEFAULT_GSETTINGS=(
  ["color-scheme"]="prefer-light"
  ["icon-theme"]="Papirus"
  ["gtk-theme"]="Adwaita"
  ["cursor-theme"]="Breeze_Snow"
  ["cursor-size"]="24"
)

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

# 新增：读取gsettings配置并执行设置
set_gsettings_from_config() {
  local selected_theme="$1"
  local config_file=$(echo "$GSETTINGS_CONF" | sed "s/{THEME_NAME}/$selected_theme/g")
  local gsettings_log=""

  # 1. 校验配置文件是否存在
  if [ ! -f "$config_file" ]; then
    notify-send -u low -a "Theme Switcher" "提示" "主题 [$selected_theme] 无gsettings配置，使用默认值"
    # 使用默认值设置
    for key in "${!DEFAULT_GSETTINGS[@]}"; do
      set_single_gsettings "$key" "${DEFAULT_GSETTINGS[$key]}"
      gsettings_log+="💡 $key: ${DEFAULT_GSETTINGS[$key]}\n"
    done
    echo -e "$gsettings_log"
    return 0
  fi

  # 2. 读取配置文件（过滤注释/空行/无效行）
  while IFS='=' read -r conf_key conf_value; do
    # 过滤注释（#开头）、空行、无等号的行
    [[ -z "$conf_key" || "$conf_key" =~ ^# || -z "$conf_value" ]] && continue
    # 去除键值两端的空格
    conf_key=$(echo "$conf_key" | tr -d '[:space:]')
    conf_value=$(echo "$conf_value" | tr -d '[:space:]')

    # 3. 校验键是否支持，无则跳过
    if [[ ! -v DEFAULT_GSETTINGS[$conf_key] ]]; then
      gsettings_log+="⚠️ 不支持的配置项：$conf_key（跳过）\n"
      continue
    fi

    # 4. 空值则用默认值
    if [ -z "$conf_value" ]; then
      conf_value="${DEFAULT_GSETTINGS[$conf_key]}"
      gsettings_log+="🔧 $conf_key: 配置为空，使用默认 $conf_value\n"
    fi

    # 5. 执行单个gsettings设置
    if set_single_gsettings "$conf_key" "$conf_value"; then
      gsettings_log+="✅ $conf_key: $conf_value\n"
    else
      gsettings_log+="❌ $conf_key: 设置失败（值：$conf_value）\n"
    fi
  done < "$config_file"

  # 6. 发送gsettings设置日志
  notify-send -u normal -a "Theme Switcher" "系统配置已更新" "$gsettings_log"
  echo -e "$gsettings_log"
}

# 新增：设置单个gsettings键值（封装通用逻辑）
set_single_gsettings() {
  local conf_key="$1"
  local conf_value="$2"
  local schema_path=""
  local schema_key=""

  # 映射配置键到对应的gsettings schema和键
  case "$conf_key" in
    color-scheme)
      schema_path="org.gnome.desktop.interface"
      schema_key="color-scheme"
      ;;
    icon-theme)
      schema_path="org.gnome.desktop.interface"
      schema_key="icon-theme"
      ;;
    gtk-theme)
      schema_path="org.gnome.desktop.interface"
      schema_key="gtk-theme"
      ;;
    cursor-theme)
      schema_path="org.gnome.desktop.interface"
      schema_key="cursor-theme"
      ;;
    cursor-size)
      schema_path="org.gnome.desktop.interface"
      schema_key="cursor-size"
      # 确保cursor-size是数字
      if ! [[ "$conf_value" =~ ^[0-9]+$ ]]; then
        conf_value="${DEFAULT_GSETTINGS[$conf_key]}"
        notify-send -u low -a "Theme Switcher" "警告" "cursor-size必须是数字，使用默认：$conf_value"
      fi
      ;;
    *)
      return 1  # 不支持的键
      ;;
  esac

  # 执行gsettings设置（容错）
  if gsettings set "$schema_path" "$schema_key" "$conf_value" 2>/dev/null; then
    return 0
  else
    # 非GNOME桌面可能设置失败，仅警告不中断
    notify-send -u low -a "Theme Switcher" "警告" "无法设置 $schema_path.$schema_key = $conf_value（非GNOME桌面？）"
    return 1
  fi
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

# ========== 核心步骤1：设置gsettings系统配置 ==========
set_gsettings_from_config "$SELECTED_THEME"

# ========== 核心步骤2：切换各应用主题 ==========
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

# ========== 发送最终通知 ==========
summary="主题已切换：$SELECTED_THEME"
body=""

if [ ${#applied_apps[@]} -gt 0 ]; then
  body+="✅ 应用主题：$(printf '%s ' "${applied_apps[@]}")\n"
fi

if [ ${#failed_apps[@]} -gt 0 ]; then
  body+="❌ 应用失败：$(printf '%s ' "${failed_apps[@]}")\n"
fi

if [ ${#applied_apps[@]} -eq 0 ] && [ ${#failed_apps[@]} -eq 0 ]; then
  body="⚠️ 未找到匹配的应用配置文件。\n支持应用：$(printf '%s ' "${!APPS[@]}")\n"
fi

notify-send -a "Theme Switcher" -t 5000 "$summary" "$body"
