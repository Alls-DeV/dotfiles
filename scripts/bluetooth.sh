#!/bin/bash

# Ensure service is running
if ! systemctl is-active --quiet bluetooth.service; then
    pkexec systemctl start bluetooth.service
    sleep 1
fi

# Ensure radio is unblocked (turned on)
# 'rfkill unblock bluetooth' usually does not require root on modern distros 
# if your user is in the 'rfkill' group, otherwise add pkexec here too.
rfkill unblock bluetooth

blueman-manager
