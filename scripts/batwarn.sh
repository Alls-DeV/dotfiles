#!/bin/sh

#############################################
# This is a simple battery warning script.  #
# It uses i3's nagbar to display warnings.  #
#                                           #
# @author agribu                            #
#############################################

# lock file location
export LOCK_FILE='/tmp/battery_state.lock'

# check if another copy is running
if [ -e "${LOCK_FILE}" ] ; then

	pid="$(awk '{print $1}' "${LOCK_FILE}")"
	ppid="$(awk '{print $2}' "${LOCK_FILE}")"
	# validate contents of previous lock file
	vpid="${pid:-"0"}"
	vppid="${ppid:-"0"}"

	if [ "${vpid}" -lt '2' ] || [ "${vppid}" -lt '2' ] ; then
		# corrupt lock file $LOCK_FILE ... Exiting
		cp -f "${LOCK_FILE}" "${LOCK_FILE}.$(date +%Y%m%d%H%M%S)"
		exit
	fi

	# check if ppid matches pid
	if ps -f -p "${pid}" --no-headers | grep -q "${ppid}" ; then
		# another copy of script running with process id ${pid}
		exit
	else
		# bogus lock file found, removing
		rm -f "${LOCK_FILE}" >/dev/null
	fi

fi

pid="$$"
ps -f -p "${pid}" --no-headers | awk '{print $2,$3}' > "${LOCK_FILE}"
# starting with process id $pid

# set Battery
BATTERY="$(echo '/sys/class/power_supply/BAT'?)"
echo "battery: ${BATTERY}"
# get battery status
STAT="$(cat "${BATTERY}/status")"
echo "status: ${STAT}"
# get remaining energy value
REM="$(grep -E "POWER_SUPPLY_(CHARGE|ENERGY)_NOW" "${BATTERY}/uevent" | cut -d '=' -f2)"
echo "remaining: ${REM}"
# get full energy value
FULL="$(grep -E "POWER_SUPPLY_(CHARGE|ENERGY)_FULL_DESIGN" "${BATTERY}/uevent" | cut -d '=' -f2)"
echo "full: ${FULL}"
# set error message
MESSAGE="Low battery warning, find charger"
# set energy limit in percent, where warning should be displayed
LIMIT="339000"

I3BAT_TMPDIR="$(mktemp --directory --tmpdir i3batwarn.XXX)"
NAGBARPIDFILE="${I3BAT_TMPDIR}/nagbarpid_file"


if [ "${REM}" -le "${LIMIT}" ] && [ "${STAT}" = "Discharging" ] ; then
    /usr/bin/dunstify -u critical "LOW BATTERY"
fi
