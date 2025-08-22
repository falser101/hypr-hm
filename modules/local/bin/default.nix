{ ... }:

{
  home.file = {
    ".local/bin/aur_install.sh" = {
      source = ./aur_install.sh;
      executable = true;
    };

    ".local/bin/hyprpaper.sh" = {
      source = ./hyprpaper.sh;
      executable = true;
    };

    ".local/bin/xdph.sh" = {
      source = ./xdph.sh;
      executable = true;
    };
  };
}
