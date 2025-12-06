#!/usr/bin/env bash

# Icons
wifi_high_stregth_icon="󰤨"
wifi_medium_strength_icon="󰤢"
wifi_low_strength_icon="󰤯"
ethernet_icon="󰈀"

volume_above_50_icon=" "
volume_below_50_icon=""
volume_muted_icon="󰖁"
headphone_icon=""
headphone_muted_icon="󰟎"

mic_on_icon=""
mic_off_icon=""

brightness_icon="󰃠"

battery_high_icon="󰂂"
battery_medium_icon="󰁽"
battery_low_icon="󰁺"
battery_charging_icon=""

bluetooth_on_icon=""
bluetooth_off_icon="󰂲"

clock_icon=""
calendar_icon=""

# Helpers
get_network() {
    if ! command -v nmcli >/dev/null 2>&1; then
        printf 'no-nmcli'
        return 0
    fi

    local dev ssid signal icon

    # Prefer ethernet if connected
    dev=$(
        nmcli -t -f DEVICE,TYPE,STATE device 2>/dev/null \
        | awk -F: '$2=="ethernet" && $3=="connected"{print $1; exit}' \
        || true
    )

    if [ -n "$dev" ]; then
        printf '%s %s' "$ethernet_icon" "$dev"
        return 0
    fi

    # Otherwise try Wi-Fi (matches your wlan0:wifi:connected output)
    dev=$(
        nmcli -t -f DEVICE,TYPE,STATE device 2>/dev/null \
        | awk -F: '$2=="wifi" && $3=="connected"{print $1; exit}' \
        || true
    )

    if [ -n "$dev" ]; then
        # Get signal of the active Wi-Fi connection
        signal=$(
            nmcli -t -f ACTIVE,SIGNAL dev wifi 2>/dev/null \
            | awk -F: '$1=="yes"{print $2; exit}' \
            || true
        )

        # Get SSID of the active Wi-Fi connection
        ssid=$(
            nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null \
            | awk -F: '$1=="yes"{print $2; exit}' \
            || true
        )

        icon="$wifi_medium_strength_icon"

        if [ -n "$signal" ]; then
            if [ "$signal" -ge 67 ] 2>/dev/null; then
                icon="$wifi_high_stregth_icon"
            elif [ "$signal" -lt 34 ] 2>/dev/null; then
                icon="$wifi_low_strength_icon"
            fi
        fi

        # Fallback if we didn't get an SSID for some reason
        [ -z "$ssid" ] && ssid="$dev"

        # Show icon + SSID (no signal percentage)
        printf '%s %s' "$icon" "$ssid"
        return 0
    fi

    # No ethernet / wifi connected – show a generic "no network" icon
    printf '󰤭'
}

get_volume() {
    local volume mute icon
    local headphones=""

    # Volume level & mute
    if command -v pamixer >/dev/null 2>&1; then
        volume=$(pamixer --get-volume 2>/dev/null)
        mute=$(pamixer --get-mute 2>/dev/null)
    elif command -v pactl >/dev/null 2>&1; then
        volume=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null \
            | awk 'NR==1{for(i=1;i<=NF;i++) if($i ~ /%$/){gsub(/%/,"",$i); print $i; break}}')
        mute=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')
    else
        printf '%s --' "$volume_muted_icon"
        return
    fi

    # Headphones detection (wired or Bluetooth) via default sink
    if command -v pactl >/dev/null 2>&1; then
        local default_sink sink_info
        default_sink=$(pactl info 2>/dev/null | awk -F': ' '/Default Sink:/{print $2; exit}' || true)

        if [ -n "$default_sink" ]; then
            # Extract only the block for the default sink
            sink_info=$(pactl list sinks 2>/dev/null | awk -v sink="$default_sink" '
                /^Sink #/ {in_sink=0}
                $1 == "Name:" && $2 == sink {in_sink=1}
                in_sink {print}
            ')
        else
            # Fallback: use all sinks (less precise, but better than nothing)
            sink_info=$(pactl list sinks 2>/dev/null)
        fi

        # Look for hints that this is a headphone/headset/a2dp device
        if printf '%s\n' "$sink_info" \
            | awk 'tolower($0) ~ /(headphone|headset|a2dp|handsfree|hsp)/ {found=1} END{exit !found}'; then
            headphones=1
        fi
    fi

    # Choose icon
    if [ "$mute" = "true" ] || [ "$mute" = "yes" ]; then
        if [ -n "$headphones" ]; then
            icon="$headphone_muted_icon"
        else
            icon="$volume_muted_icon"
        fi
    else
        if [ -n "$headphones" ]; then
            icon="$headphone_icon"
        else
            if [ -n "$volume" ] && [ "$volume" -gt 50 ] 2>/dev/null; then
                icon="$volume_above_50_icon"
            else
                icon="$volume_below_50_icon"
            fi
        fi
    fi

    if [ -n "$volume" ]; then
        if [ "$mute" = "true" ] || [ "$mute" = "yes" ]; then
            printf '<span foreground="#FFC100">%s %s%%</span>' "$icon" "$volume"
        else
            printf '%s %s%%' "$icon" "$volume"
        fi
    else
        if [ "$mute" = "true" ] || [ "$mute" = "yes" ]; then
            printf '<span foreground="#FFC100">%s --</span>' "$icon"
        else
            printf '%s --' "$icon"
        fi
    fi
}

get_microphone() {
    local volume mute icon

    # Try with pamixer (PipeWire/PulseAudio)
    if command -v pamixer >/dev/null 2>&1; then
        if pamixer --default-source --get-mute >/dev/null 2>&1; then
            volume=$(pamixer --default-source --get-volume 2>/dev/null)
            mute=$(pamixer --default-source --get-mute 2>/dev/null)
        fi
    fi

    # Fallback to pactl if pamixer didn't give us anything
    if [ -z "$mute" ] && command -v pactl >/dev/null 2>&1; then
        volume=$(pactl get-source-volume @DEFAULT_SOURCE@ 2>/dev/null \
            | awk 'NR==1{for(i=1;i<=NF;i++) if($i ~ /%$/){gsub(/%/,"",$i); print $i; break}}')
        mute=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | awk '{print $2}')
    fi

    # If we still don't know, assume "off" / unavailable
    if [ -z "$mute" ]; then
        printf '%s --' "$mic_off_icon"
        return 0
    fi

    if [ "$mute" = "true" ] || [ "$mute" = "yes" ]; then
        icon="$mic_off_icon"
    else
        icon="$mic_on_icon"
    fi

    if [ -n "$volume" ]; then
        if [ "$mute" = "true" ] || [ "$mute" = "yes" ]; then
            printf '<span foreground="#FFC100">%s %s%%</span>' "$icon" "$volume"
        else
            printf '%s %s%%' "$icon" "$volume"
        fi
    else
        if [ "$mute" = "true" ] || [ "$mute" = "yes" ]; then
            printf '<span foreground="#FFC100">%s</span>' "$icon"
        else
            printf '%s' "$icon"
        fi
    fi
}

get_brightness() {
    local perc=""
    if command -v brightnessctl >/dev/null 2>&1; then
        local current max
        current=$(brightnessctl g 2>/dev/null)
        max=$(brightnessctl m 2>/dev/null)
        if [ -n "$current" ] && [ -n "$max" ] && [ "$max" -gt 0 ] 2>/dev/null; then
            perc=$(( current * 100 / max ))
        fi
    fi

    if [ -n "$perc" ]; then
        printf '%s %s%%' "$brightness_icon" "$perc"
    else
        printf '%s --' "$brightness_icon"
    fi
}

get_battery() {
    local path capacity status icon low_battery

    path=$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' | head -n1)
    if [ -z "$path" ]; then
        printf '%s --' "$battery_high_icon"
        return
    fi

    [ -r "$path/capacity" ] && capacity=$(cat "$path/capacity")
    [ -r "$path/status" ] && status=$(cat "$path/status")

    if [ "$status" = "Charging" ]; then
        icon="$battery_charging_icon"
    else
        if [ "$capacity" -ge 80 ] 2>/dev/null; then
            icon="$battery_high_icon"
        elif [ "$capacity" -ge 30 ] 2>/dev/null; then
            icon="$battery_medium_icon"
        else
            icon="$battery_low_icon"
            low_battery=1
        fi
    fi

    if [ "${low_battery:-0}" -eq 1 ]; then
        printf '<span foreground="#DC322F">%s %s%%</span>' "$icon" "$capacity"
    else
        printf '%s %s%%' "$icon" "$capacity"
    fi
}

get_bluetooth() {
    # Default: assume Bluetooth is off
    local state_icon="$bluetooth_off_icon"

    # If systemd is present and bluetooth.service is NOT active, just show "off" and exit
    if command -v systemctl >/dev/null 2>&1; then
        if ! systemctl is-active --quiet bluetooth.service 2>/dev/null; then
            printf '%s' "$state_icon"
            return 0
        fi
    fi

    # Service is active (or we can't check), so try bluetoothctl
    if command -v bluetoothctl >/dev/null 2>&1; then
        local powered
        powered=$(
            bluetoothctl show 2>/dev/null \
            | awk -F': ' '/Powered:/{print $2; exit}' \
            || true
        )

        if [ "$powered" = "yes" ]; then
            state_icon="$bluetooth_on_icon"
        fi
    fi

    printf '%s' "$state_icon"
}


# Build line
network="$(get_network)"
volume="$(get_volume)"
microphone="$(get_microphone)"
brightness="$(get_brightness)"
battery="$(get_battery)"
bluetooth="$(get_bluetooth)"
clock="$clock_icon $(date '+%H:%M')"
calendar="$calendar_icon $(date '+%d-%m-%Y')"

echo "$network   $volume   $microphone   $brightness   $battery   $bluetooth   $clock   $calendar"
