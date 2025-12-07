# ~/.config/home-manager/modules/theme.nix
{
  pkgs,
  config,
  lib,
  ...
}:
{
  xdg.dataFile."nide/themes".source = ./themes;
  home.activation.createKittyDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.xdg.configHome}/kitty"
    echo "已创建 kitty 配置目录：${config.xdg.configHome}/kitty"
  '';
}
