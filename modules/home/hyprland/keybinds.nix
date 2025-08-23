{
  config,
  lib,
  setup,
  ...
}: {
  "$mainMod" = "SUPER";

  bind =
    [
      "$mainMod, Return, exec, $terminal"
      "$mainMod, W, killactive,"
      "$mainMod CTRL, Q, exit,"
      "$mainMod, E, exec, $filemanager"
      "$mainMod, V, togglefloating,"
      "$mainMod, R, exec, $menu"
      "$mainMod, P, pseudo,"
      "$mainMod, J, togglesplit,"
      "$mainMod, F, fullscreen, 1"
      "$mainMod, M, fullscreen, 0"
      "$mainMod, L, exec, hyprlock"

      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Example special workspace (scratchpad)
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ]
    // lib.lists.optionals (setup == "default") [
      ", Print, exec, hyprshot -m region"
      "$mainMod, Print, exec, hyprshot -m output"
    ];

  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  # Laptop multimedia keys for volume and LCD brightness
  bindel = [
    ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
    ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
    ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
    ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"

    ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
    ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
  ];
  # Requires playerctl
  bindl = lib.lists.optionals config.services.playerctld.enable [
    ", XF86AudioNext, exec, playerctl next"
    ", XF86AudioPause, exec, playerctl play-pause"
    ", XF86AudioPlay, exec, playerctl play-pause"
    ", XF86AudioPrev, exec, playerctl previous"
  ];
}
