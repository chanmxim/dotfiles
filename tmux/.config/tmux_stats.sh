#!/usr/bin/env bash

# Calculate CPU usage from /proc/stat
read -r _ user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
prev_idle=$((idle + iowait))
prev_total=$((user + nice + system + idle + iowait + irq + softirq + steal))

sleep 0.5

read -r _ user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

# Compute total BEFORE folding iowait into idle to avoid double-counting
total=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle=$((idle + iowait))

total_diff=$((total - prev_total))
idle_diff=$((idle - prev_idle))

# Guard against divide-by-zero (e.g. in low-resolution VM/container clocks)
if [[ $total_diff -eq 0 ]]; then
    cpu_usage=0
else
    # +total_diff/2 rounds to nearest integer instead of truncating
    cpu_usage=$(( (100 * (total_diff - idle_diff) + total_diff / 2) / total_diff ))
fi

# Calculate RAM usage directly from /proc/meminfo
read -r total_mem avail_mem < <(
    awk '/^MemTotal/{t=$2} /^MemAvailable/{a=$2} END{print t, a}' /proc/meminfo
)

used_mem=$((total_mem - avail_mem))

if [[ $total_mem -eq 0 ]]; then
    ram_usage=0
else
    ram_usage=$(( (100 * used_mem + total_mem / 2) / total_mem ))
fi

# Output the stats
echo "  ${cpu_usage}%   ${ram_usage}%"
