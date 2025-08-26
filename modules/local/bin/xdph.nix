{ pkgs, ... }:

with pkgs.lib;
{
  # 声明选项
  options.xdph = mkOption {
    type = types.package;
    description = "A script to install AUR packages using paru";
  };
  config.xdph = pkgs.writeShellScriptBin "xdph" ''
    #!/bin/sh
    sleep 1
    killall -e xdg-desktop-portal-hyprland
    killall xdg-desktop-portal
    /usr/lib/xdg-desktop-portal-hyprland &
    sleep 2
    /usr/lib/xdg-desktop-portal &
  '';
}
