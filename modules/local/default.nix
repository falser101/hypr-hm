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
  home.file.".local/bin/dunst-status" = {
    text = builtins.readFile ./bin/dunst-status.sh;
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
  home.file.".local/share/wlogout" = {
    source = ./share/wlogout;
  };
}
