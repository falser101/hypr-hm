{ ... }:

{
  xdg.configFile."hypr/windowrules.conf".text = ''
    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # idleinhibit rules
    windowrule = idleinhibit fullscreen, class:^(.*celluloid.*)$|^(.*mpv.*)$|^(.*vlc.*)$
    windowrule = idleinhibit fullscreen, class:^(.*[Ss]potify.*)$
    windowrule = idleinhibit fullscreen, class:^(.*LibreWolf.*)$|^(.*floorp.*)$|^(.*brave-browser.*)$|^(.*firefox.*)$|^(.*chromium.*)$|^(.*zen.*)$|^(.*vivaldi.*)$

    # Picture-in-Picture
    windowrule = float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$
    windowrule = keepaspectratio, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$
    windowrule = move 73% 72%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$
    windowrule = size 25%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$
    windowrule = float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$
    windowrule = pin, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$

    windowrule = opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$ # Clapper-Gtk
    windowrule = opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$ # Flatseal-Gtk
    windowrule = opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$ # Cartridges-Gtk
    windowrule = opacity 0.80 0.80,class:^(com.obsproject.Studio)$ # Obs-Qt
    windowrule = opacity 0.80 0.80,class:^(gnome-boxes)$ # Boxes-Gtk
    windowrule = opacity 0.80 0.80,class:^(vesktop)$ # Vesktop
    windowrule = opacity 0.80 0.80,class:^(discord)$ # Discord-Electron
    windowrule = opacity 0.80 0.80,class:^(WebCord)$ # WebCord-Electron
    windowrule = opacity 0.80 0.80,class:^(ArmCord)$ # ArmCord-Electron
    windowrule = opacity 0.80 0.80,class:^(app.drey.Warp)$ # Warp-Gtk
    windowrule = opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$ # ProtonUp-Qt
    windowrule = opacity 0.80 0.80,class:^(yad)$ # Protontricks-Gtk
    windowrule = opacity 0.80 0.80,class:^(Signal)$ # Signal-Gtk
    windowrule = opacity 0.80 0.80,class:^(io.github.alainm23.planify)$ # planify-Gtk
    windowrule = opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$ # Upscaler-Gtk
    windowrule = opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$ # VideoDownloader-Gtk
    windowrule = opacity 0.80 0.80,class:^(io.gitlab.adhami3310.Impression)$ # Impression-Gtk
    windowrule = opacity 0.80 0.80,class:^(io.missioncenter.MissionCenter)$ # MissionCenter-Gtk
    windowrule = opacity 0.80 0.80,class:^(io.github.flattool.Warehouse)$ # Warehouse-Gtk

    windowrule = float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$
    windowrule = float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$
    windowrule = float,title:^(About Mozilla Firefox)$
    windowrule = float,class:^(firefox)$,title:^(Picture-in-Picture)$
    windowrule = float,class:^(firefox)$,title:^(Library)$
    windowrule = float,class:^(kitty)$,title:^(top)$
    windowrule = float,class:^(kitty)$,title:^(btop)$
    windowrule = float,class:^(kitty)$,title:^(htop)$
    windowrule = float,class:^(vlc)$
    windowrule = float,class:^(kvantummanager)$
    windowrule = float,class:^(qt5ct)$
    windowrule = float,class:^(qt6ct)$
    windowrule = float,class:^(nwg-look)$
    windowrule = float,class:^(org.kde.ark)$
    windowrule = float,class:^(org.pulseaudio.pavucontrol)$
    windowrule = float,class:^(blueman-manager)$
    windowrule = float,class:^(nm-applet)$
    windowrule = float,class:^(nm-connection-editor)$
    windowrule = float,class:^(org.kde.polkit-kde-authentication-agent-1)$

    windowrule = float,class:^(Signal)$ # Signal-Gtk
    windowrule = float,class:^(com.github.rafostar.Clapper)$ # Clapper-Gtk
    windowrule = float,class:^(app.drey.Warp)$ # Warp-Gtk
    windowrule = float,class:^(net.davidotek.pupgui2)$ # ProtonUp-Qt
    windowrule = float,class:^(yad)$ # Protontricks-Gtk
    windowrule = float,class:^(eog)$ # Imageviewer-Gtk
    windowrule = float,class:^(io.github.alainm23.planify)$ # planify-Gtk
    windowrule = float,class:^(io.gitlab.theevilskeleton.Upscaler)$ # Upscaler-Gtk
    windowrule = float,class:^(com.github.unrud.VideoDownloader)$ # VideoDownloader-Gkk
    windowrule = float,class:^(io.gitlab.adhami3310.Impression)$ # Impression-Gtk
    windowrule = float,class:^(io.missioncenter.MissionCenter)$ # MissionCenter-Gtk

    # common modals
    windowrule = float,title:^(Open)$
    windowrule = float, title:^(Authentication Required)$
    windowrule = float, title:^(Add Folder to Workspace)$
    windowrule = float,initialtitle:^(Open File)$
    windowrule = float,title:^(Choose Files)$
    windowrule = float,title:^(Save As)$
    windowrule = float,title:^(Confirm to replace files)$
    windowrule = float,title:^(File Operation Progress)$
    windowrule = float,class:^([Xx]dg-desktop-portal-gtk)$
    windowrule = float, title:^(File Upload)(.*)$
    windowrule = float, title:^(Choose wallpaper)(.*)$
    windowrule = float, title:^(Library)(.*)$
    windowrule = float,class:^(.*dialog.*)$
    windowrule = float,title:^(.*dialog.*)$

    # █░░ ▄▀█ █▄█ █▀▀ █▀█   █▀█ █░█ █░░ █▀▀ █▀
    # █▄▄ █▀█ ░█░ ██▄ █▀▄   █▀▄ █▄█ █▄▄ ██▄ ▄█

    layerrule = blur,wofi
    layerrule = ignorezero,wofi
    layerrule = blur,notifications
    layerrule = ignorezero,notifications
    layerrule = blur,swaync-notification-window
    layerrule = ignorezero,swaync-notification-window
    layerrule = blur,swaync-control-center
    layerrule = ignorezero,swaync-control-center
    layerrule = blur,logout_dialog

    # 修复XWayland窗口拖动问题
    windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

    windowrulev2 = workspace 6, class:^wemeetapp$, title:^wemeetapp$
    windowrulev2 = workspace 6, class:^wemeetapp$, title:^腾讯会议$
    windowrulev2 = workspace 6, class:^Meeting$, title:^飞书会议$
  '';
}
