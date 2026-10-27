---------------------------
---- CLAMSHELL MODE -------
---------------------------

-- Disable internal monitor when the lid is closed
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("bash /home/chanmxim/.config/hypr/scripts/lid.sh close"), { locked = true })

-- Re-enable internal monitor when the lid is opened
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("bash /home/chanmxim/.config/hypr/scripts/lid.sh open"), { locked = true })

-- Handle case where laptop boots with the lid already closed
hl.on("hyprland.start", function ()
    hl.exec_cmd('grep -q "closed" /proc/acpi/button/lid/LID*/state && hyprctl keyword monitor "eDP-1, disable"')
end)
