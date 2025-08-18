{ ... }:

{
  xdg.configFile."waybar/config.jsonc".text = ''
    {
        // "layer": "top", // Waybar at top layer
        // "position": "bottom", // Waybar position (top|bottom|left|right)
        "height": 32, // Waybar height (to be removed for auto height)
        // "width": 1280, // Waybar width
        "spacing": 4, // Gaps between modules (4px)
        // Choose the order of the modules
        "include": [
          "modules/*jsonc*"
        ],
        "modules-left": [
            "hyprland/workspaces",
            "cpu",
            "memory",
            "temperature",
        ],
        "modules-center": [
            "wlr/taskbar"
        ],
        "modules-right": [
            "group/pill#right1",
            "group/pill#right2",
        ],
        "group/pill#right1": {
            "modules": [
                "bluetooth",
                "network",
                "pulseaudio",
                "pulseaudio#microphone",
            ],
            "orientation": "inherit"
        },
        "group/pill#right2": {
            "modules": [
                "keyboard-state",
                "clock",
                "tray",
                "custom/power"
            ],
            "orientation": "inherit"
        },
        "keyboard-state": {
            "numlock": true,
            "capslock": true,
            "format": "{name} {icon}",
            "format-icons": {
                "locked": "",
                "unlocked": ""
            }
        },
        "custom/media": {
            "format": "{icon} {text}",
            "return-type": "json",
            "max-length": 40,
            "format-icons": {
                "spotify": "",
                "default": "🎜"
            },
            "escape": true,
            "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" // Script in resources folder
            // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
        },
        "custom/power": {
          "format" : "⏻ ",
      		"tooltip": false,
      		"on-click": "wlogout"
        }
    }
  '';
}
