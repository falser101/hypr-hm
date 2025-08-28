{ pkgs, ... }:

with pkgs.lib;
{
  # 声明选项
  options.dontkillsteam = mkOption {
    type = types.package;
    description = "dontkillsteam";
  };
  config.dontkillsteam = pkgs.writeShellScriptBin "dontkillsteam" ''
    if [[ $(hyprctl activewindow -j | jq -r ".class") == "Steam" ]]; then
        xdotool windowunmap $(xdotool getactivewindow)
    else
        hyprctl dispatch killactive ""
    fi
  '';
}
