{ config, pkgs, ... }:

{
  # Qtile
  home.file.".config/qtile/autostart.sh".text = ''
#!/bin/sh
picom & disown #should prevent screen tearing on most setups if needed

# Low battery notifier
~/.config/qtile/scripts/check_battery.sh & disown
  '';

  home.file.".config/qtile/config.py".text = ''
# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import qtile
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook
import os
import subprocess

mod = "mod4"
terminal = "alacritty"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift", "control"], "h", lazy.layout.swap_column_left()),
    Key([mod, "shift", "control"], "l", lazy.layout.swap_column_right()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key(
        [mod, "control"],
        "q",
        lazy.spawn(os.path.expanduser("~/.config/rofi/powermenu.sh")),
        desc="Execute Rofi powermenu",
    ),
    Key(
        [mod],
        "r",
        lazy.spawn("rofi -show drun"),
        desc="Spawn a command using a prompt widget using rofi",
    ),
    # (CUSTOM) Audio Keybindings to the Function Keys
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 5%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 5%+")),
    Key([mod], "F6", lazy.spawn("brightnessctl s +10%")),
    Key([mod], "F5", lazy.spawn("brightnessctl s 10%-")),

]


groups = [Group(i) for i in "12345"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key([mod], "Right", lazy.screen.next_group(), desc="Switch to next group"),
            Key(
                [mod], "Left", lazy.screen.prev_group(), desc="Switch to previous group"
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

defaultLayoutMargin = 12
layouts = [
    layout.MonadTall(
        margin=defaultLayoutMargin,
        border_focus="#5294e2",
        border_normal="2c5380",
        border_width=2,
    ),
    layout.Max(margin=defaultLayoutMargin),
    layout.Columns(
        margin=defaultLayoutMargin,
        border_focus_stack=["#d75f5f", "#8f3d3d"],
        border_width=2,
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# Colors
catpuccin = {
    "rosewater": "#f4dbd6",
    "flamingo": "#f0c6c6",
    "pink": "#f5bde6",
    "mauve": "#c6a0f6",
    "red": "#ed8796",
    "maroon": "#ee99a0",
    "peach": "#f5a97f",
    "yellow": "#eed49f",
    "green": "#a6da95",
    "teal": "#8bd5ca",
    "sky": "#91d7e3",
    "sapphire": "#7dc4e4",
    "blue": "#8aadf4",
    "lavender": "#b7bdf8",
    "text": "#cad3f5",
    "subtext1": "#b8c0e0",
    "subtext0": "#a5adcb",
    "overlay2": "#939ab7",
    "overlay1": "#8087a2",
    "overlay0": "#6e738d",
    "surface2": "#5b6078",
    "surface1": "#494d64",
    "surface0": "#363a4f",
    "base": "#24273a",
    "mantle": "#1e2030",
    "crust": "#181926",
}


widget_defaults = dict(
    #font="Ubuntu Bold",
    font = "JetBrains Mono Nerd Font ExtraBold",
    fontsize=13,
    padding=3,
)
# extension_defaults = widget_defaults.copy()
shape_fontsize = 18
screens = [
    Screen(
        # wallpaper='/home/shreyd/Pictures/endy_vector_eos-plant_catppuccinified.png',
        wallpaper="/home/shreyd/Pictures/Wallpapers/wallpapers/misc/Upscaled/comfy-home_upscayl_16x_realesrgan-x4plus-anime.png",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.Sep(
                    padding=3,
                    linewidth=0,
                    background=catpuccin["red"],
                ),
                widget.GroupBox(
                    highlight_method="block",
                    this_screen_border="#5294e2",
                    this_current_screen_border="#5294e2",
                    active=catpuccin["text"],
                    inactive=catpuccin["surface1"],
                    background=catpuccin["red"],
                ),
                widget.TextBox(
                    text="",
                    padding=0,
                    fontsize=shape_fontsize,
                    foreground=catpuccin["red"],
                    background=catpuccin["peach"],
                ),
                widget.Spacer(
                    length=5,
                    background=catpuccin["peach"],
                ),
                widget.CurrentLayoutIcon(
                    scale=0.75,
                    background=catpuccin["peach"],
                ),
                widget.CurrentLayout(
                    background=catpuccin["peach"],
                    foreground=catpuccin["crust"],
                ),
                widget.Spacer(
                    length=5,
                    background=catpuccin["peach"],
                ),
                widget.TextBox(
                    text="",
                    padding=0,
                    fontsize=shape_fontsize,
                    foreground=catpuccin["peach"],
                ),
                widget.Spacer(
                    length=8,
                ),
                widget.WindowName(
                    foreground=catpuccin["yellow"],
                    fmt="{}",
                ),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                #widget.TextBox(
                #    text="",
                #    padding=0,
                #    fontsize=shape_fontsize,
                #    foreground=catpuccin["yellow"],
                #),
                #widget.Sep(
                #    padding=3,
                #    linewidth=0,
                #    background=catpuccin["yellow"],
                #),
                #widget.Net(
                #    foreground=catpuccin["crust"],
                #    background=catpuccin["yellow"]
                #),
                #widget.Sep(
                #    padding=3,
                #    linewidth=0,
                #    background=catpuccin["yellow"],
                #),
                widget.TextBox(
                    text="",
                    padding=0,
                    fontsize=shape_fontsize,
                    #    background=catpuccin["yellow"],
                    foreground=catpuccin["green"],
                ),
                widget.Spacer(
                    length=3,
                    background=catpuccin["green"],
                ),
                widget.BatteryIcon(
                    background=catpuccin["green"],
                ),
                widget.Battery(
                    format="{percent:2.0%}",
                    update_interval=30,
                    background=catpuccin["green"],
                    foreground=catpuccin["crust"],
                ),
                widget.Spacer(
                    length=5,
                    background=catpuccin["green"],
                ),
                widget.Systray(
                    icon_size=20,
                    background=catpuccin["green"],
                    foreground=catpuccin["crust"],
                ),

                widget.TextBox(
                    text="󰕾",
                    foreground=catpuccin["crust"],
                    background=catpuccin["green"],
                ),
                widget.Volume(
                    # theme_path='/home/shreyd/.config/qtile/volume-icons',
                    background=catpuccin["green"],
                    foreground=catpuccin["crust"],
                ),
                widget.Spacer(
                    length=8,
                    background=catpuccin["green"],
                ),
                widget.TextBox(
                    text="",
                    padding=0,
                    fontsize=shape_fontsize,
                    background=catpuccin["green"],
                    foreground=catpuccin["blue"],
                ),
                widget.Clock(
                    format="  %a %m - %d - %Y %I:%M %p",
                    background=catpuccin["blue"],
                    foreground=catpuccin["crust"],
                ),
                widget.Spacer(
                    length=5,
                    background=catpuccin["blue"],
                ),
                widget.TextBox(
                    text="",
                    padding=0,
                    fontsize=shape_fontsize,
                    background=catpuccin["blue"],
                    foreground=catpuccin["mauve"],
                ),
                 widget.QuickExit(
                    background=catpuccin["mauve"],
                    foreground=catpuccin["crust"],
                    default_text = "",
                    countdown_format = "[{}]",
                    padding = 8,
                ),
                #widget.TextBox(
                #    text="",
                #    background=catpuccin["lavender"],
                #    mouse_callbacks={
                #        "Button1": lambda: qtile.cmd_spawn(
                #            os.path.expanduser("~/.config/rofi/powermenu.sh")
                #        )
                #    },
                #    foreground=catpuccin["crust"],
                #),
                widget.Spacer(
                    length=15,
                    background=catpuccin["mauve"],
                ),
            ],
            20,  # height in px
            #background=catpuccin["base"],  # background color
            background="#00000000",
        ),
    ),
]


"""
screens = [
    Screen(
        wallpaper='/usr/share/endeavouros/backgrounds/Community-wallpapers-main/eos_wallpapers_community/Endy_vector_EOS-planet.png',
        wallpaper_mode='stretch',
        top=bar.Bar(
            [
                widget.Sep(padding=3, linewidth=0, background=catpuccin["red"]),
                widget.GroupBox(
                    highlight_method='block',
                    this_screen_border="#5294e2",
                    this_current_screen_border="#5294e2",
                    active="#ffffff",
                    inactive=catpuccin["base"],
                    background=catpuccin["red"]),
                widget.TextBox(
                    text = '',
                    padding = 0,
                    fontsize = 28,
                    foreground=catpuccin["red"]
                    ),
                widget.Spacer(
                    length = 6
                    ),

                widget.Spacer(
                    length=6
                    ),
                widget.TextBox(
                    text = "",
                    padding=0,
                    fontsize=19,
                    foreground=catpuccin["peach"],
                    ),
                widget.WindowName(
                    background = catpuccin["peach"],
                    foreground = catpuccin["crust"]
                    ),
                widget.TextBox(
                    text = "",
                    padding=0,
                    fontsize=19,
                    foreground=catpuccin["peach"],
                    ),
                widget.Spacer(
                    length=240
                    ),

                widget.GroupBox(
                    fontsize = 13,
                    highlight_method = 'block',
                    active=catpuccin["text"],
                    inactive=catpuccin["surface1"]
                    ),
                widget.Spacer(
                    length=580,
                    ),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                    ),
                widget.Systray(
                    ),
                widget.Clock(
                    format="%m-%d-%Y %a %I:%M %p"
                    ),
                widget.Battery(
                    format = '{percent:2.0}',
                    update_interval = 30,
                    ),
                widget.CheckUpdates(
                    update_interval = 1800,
                    distro="Arch_yay",
                    display_format="{updates} Updates",),
                widget.QuickExit(
                    foreground = '#D2042D'
                    )
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]
"""
# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
'';
  
  home.file.".config/qtile/scripts/check_battery.sh".text = ''
  #!/bin/sh

#start notifier script
~/.config/qtile/scripts/low_bat_notifier.sh

#low battery level, you can modify it
low_bat=26

#Do not modify these variables
charging="fully-charged"
not_charging="discharging"
bat_now=$(cat /sys/class/power_supply/BAT0/capacity)
check=2

#I check if the battery is not charging, the script is not running and the battery
#perchantage is higher than low battery or if the battery was charging before.
#In this way the user can receive notification each time the battery level is low
#without spamming notifications

while true
do
	check_running=$(pgrep -fl low_battery.sh)
	state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk '{print $2}')
	if [ "$state" = "$charged" ]; then
		check=1
		sleep 30
	elif [ "$state" = "$not_charging" ] && [ -z "$check_running" ] && ( [ "$bat_now" -gt "$low_bat" ]  || [ "$check" -lt 2 ] );then
	else
		sleep 30
		~/.config/qtile/scripts/low_bat_notifier.sh
	fi
done
  '';
  home.file.".config/qtile/scripts/low_bat_notifier.sh".text = ''
  #!/bin/bash

### VARIABLES

POLL_INTERVAL=90     # seconds at which to check battery level
LOW_BAT=26          # lesser than this is considered low battery

# If BAT0 doesn't work for you, check available devices with command below
#
#   $ ls -1 /sys/class/power_supply/
#
BAT_PATH=/sys/class/power_supply/BAT1
BAT_STAT=$BAT_PATH/status

if [[ -f $BAT_PATH/charge_full ]]
then
    BAT_FULL=$BAT_PATH/charge_full
    BAT_NOW=$BAT_PATH/charge_now
elif [[ -f $BAT_PATH/energy_full ]]
then
    BAT_FULL=$BAT_PATH/energy_full
    BAT_NOW=$BAT_PATH/energy_now
else
    exit
fi


#check if the notification is launched 3 times, then quit the script
launched=0

# Run only if battery is detected
if ls -1qA /sys/class/power_supply/ | grep -q .
then
    while true
    do
        bf=$(cat $BAT_FULL)
        bn=$(cat $BAT_NOW)
        bs=$(cat $BAT_STAT)

        bat_percent=$(( 100 * $bn / $bf ))
        if [[ $bat_percent -lt $LOW_BAT && "$bs" = "Discharging" ]]
        then
            notify-send --urgency=critical --expire-time=5000 "$bat_percent% : Low Battery!"
	    launched=$((launched+1))
	    (( "$launched" == 3 )) && exit
        fi
        sleep $POLL_INTERVAL
    done
fi
  '';


}
