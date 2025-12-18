{ ... }:

{

  home.file.".local/bin/aurInstall" = {
    text = builtins.readFile ./bin/aurInstall.sh;
    executable = true;
  };
  home.file.".local/bin/brightness" = {
    text = builtins.readFile ./bin/brightness.sh;
    executable = true;
  };
  home.file.".local/bin/cpu-temp" = {
    text = builtins.readFile ./bin/cpu-temp.sh;
    executable = true;
  };
  home.file.".local/bin/focus-feishu" = {
    text = builtins.readFile ./bin/focus-feishu.sh;
    executable = true;
  };
  home.file.".local/bin/find_niri_window" = {
    text = builtins.readFile ./bin/find_niri_window.sh;
    executable = true;
  };
  home.file.".local/bin/volume-ctl" = {
    text = builtins.readFile ./bin/volume-ctl.sh;
    executable = true;
  };

  home.file.".local/bin/gpu-temp" = {
    text = builtins.readFile ./bin/gpu-temp.sh;
    executable = true;
  };
  home.file.".local/bin/swww-wallpaper" = {
    text = builtins.readFile ./bin/wallpaper.sh;
    executable = true;
  };
  home.file.".local/bin/switch-theme" = {
    text = builtins.readFile ./bin/switch-theme.sh;
    executable = true;
  };
  home.file.".local/share/wlogout" = {
    source = ./share/wlogout;
  };
  home.file.".local/share/rofi" = {
    source = ./share/rofi;
  };
}
