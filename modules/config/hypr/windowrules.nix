{ ... }:

{
  xdg.configFile."hypr/windowrules.conf".text = ''
    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # 工作区智能间隙（取消注释启用）
    # workspace = w[tv1], gapsout:0, gapsin:0
    # workspace = f[1], gapsout:0, gapsin:0
    # windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
    # windowrule = rounding 0, floating:0, onworkspace:w[tv1]
    # windowrule = bordersize 0, floating:0, onworkspace:f[1]
    # windowrule = rounding 0, floating:0, onworkspace:f[1]

    # 忽略应用的最大化请求
    windowrule = suppressevent maximize, class:.*

    # 修复XWayland窗口拖动问题
    windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

    windowrulev2 = workspace 6, class:^wemeetapp$, title:^wemeetapp$
    windowrulev2 = workspace 6, class:^wemeetapp$, title:^腾讯会议$
    windowrulev2 = workspace 6, class:^Meeting$, title:^飞书会议$
  '';
}
