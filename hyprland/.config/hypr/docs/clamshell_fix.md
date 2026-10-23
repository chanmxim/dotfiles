# Troubleshooting Report: Hyprland Clamshell Mode Implementation

**Objective:** Configure a stable "clamshell mode" on a laptop running Hyprland with a custom Lua-based configuration engine. The desired behavior was to automatically disable the internal display (`eDP-1`) when the lid is closed, seamlessly migrating active workspaces to an external HDMI monitor without losing the video signal.

**Initial State:** Systemd power management was correctly configured to ignore the lid switch (`HandleLidSwitch=ignore`). However, the Hyprland bindings intended to disable the monitor were failing silently.

---

### Phase 1: The Configuration Engine Conflict

**Issue:** The initial approach used standard Hyprland `hyprctl keyword` commands bound to the lid switch in `hyprland.lua`. These commands failed because the custom Lua configuration wrapper strictly blocked legacy keyword parsers, throwing the error: `keyword can't work with non-legacy parsers. Use eval.`
**Resolution Path:**

1. Attempted to bypass the keyword parser using the `dpms` dispatcher directly in the Lua config (`hl.dsp.dpms`).
2. While `dpms off` successfully turned off the backlight, it failed to trigger a layout recalculation. This left active windows "trapped" on the disabled laptop screen and caused the external monitor to display a blank desktop.
3. Shifted to using the `hyprctl eval` command to communicate natively with the Lua parser. After testing syntax, we identified that the parser required the boolean flag `disabled=true` rather than setting the display mode to the string "disable".

### Phase 2: The Compositor Blocking Issue

**Issue:** To execute the complex `eval` commands and manage the lid states, the logic was migrated to an external bash script (`lid.sh`). When tied to the lid switch, the external monitor instantly dropped its HDMI signal.
**Resolution Path:**

1. A sleep timer (`sleep 2`) was introduced to test for race conditions between the Linux kernel's ACPI event and Hyprland's display pipeline.
2. The sleep command inadvertently froze the entire Wayland compositor for two seconds. Because the compositor event loop was blocked, it stopped pushing video frames to the HDMI port, causing the immediate "No Signal" crash.
3. The script was rewritten to execute the monitor commands in a detached background subshell, allowing Hyprland to process the lid switch event instantly without freezing the display pipeline.

### Phase 3: Hardware Bouncing and State Management

**Issue:** Even with the compositor unblocked, the HDMI signal continued to drop occasionally upon closing the lid.
**Resolution Path:**

1. Diagnostic logging was added to the bash script to capture timestamps and execution counts.
2. The logs revealed a "hardware bounce"—the physical magnetic lid sensor was firing multiple ON/OFF signals in a fraction of a millisecond. This bombarded the display pipeline with conflicting monitor commands, crashing the HDMI output.
3. Implemented a debounce mechanism using a temporary state file (`/tmp/hypr_lid_state`). The script was updated to check this file and only execute the monitor command if the lid state had actually changed, successfully filtering out the rapid-fire hardware misfires.

### Phase 4: Execution Permissions

**Issue:** The newly created bash script with the debounce logic was still not executing when the lid was closed; the log files were not being generated.
**Resolution Path:**

1. Verified file permissions were correct (`chmod +x`).
2. Discovered that the Lua `exec_cmd` dispatcher could not natively invoke the `.sh` script file without an explicit interpreter.
3. Appended `bash` to the start of the `exec_cmd` string in `hyprland.lua`.

---

### Final Implementation

The setup is now stable and resolves all parser conflicts, compositor freezes, and hardware bouncing.

**1. Hyprland Configuration (`~/.config/hypr/hyprland.lua`):**
The bindings explicitly call the bash interpreter to run the external script:

```lua
-- Disable internal monitor when the lid is closed
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("bash /home/chanmxim/.config/hypr/lid.sh close"), { locked = true })

-- Re-enable internal monitor when the lid is opened
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("bash /home/chanmxim/.config/hypr/lid.sh open"), { locked = true })

```

**2. State-Managed Execution Script (`~/.config/hypr/lid.sh`):**
The script handles debouncing via a temporary text file and safely passes the correct boolean syntax to the Lua configuration engine via `eval`.

```bash
#!/bin/bash
STATE_FILE="/tmp/hypr_lid_state"
CURRENT_STATE=$(cat "$STATE_FILE" 2>/dev/null)

if [[ $1 == "close" ]]; then
    if [[ "$CURRENT_STATE" != "closed" ]]; then
        echo "closed" > "$STATE_FILE"
        /usr/bin/hyprctl eval 'hl.monitor({output="eDP-1", disabled=true})'
    fi
else
    if [[ "$CURRENT_STATE" != "open" ]]; then
        echo "open" > "$STATE_FILE"
        /usr/bin/hyprctl eval 'hl.monitor({output="eDP-1", disabled=false, mode="1920x1080@60", position="auto", scale="1.33"})'
    fi
fi

```
