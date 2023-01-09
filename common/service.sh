#!/system/bin/sh
MODDIR=${0%/*}

# Execute script by tytydraco and his project ktweak, thanks! 
write() {
	# Bail out if file does not exist
	[[ ! -f "$1" ]] && return 1
	
	# Make file writable in case it is not already
	chmod +w "$1" 2> /dev/null

	# Write the new value and bail if there's an error
	if ! echo "$2" > "$1" 2> /dev/null
	then
		echo "Failed: $1 → $2"
		return 1
	fi
}

sleep 60

####################################
# UnityFix @modulostk [Telegram]
#Report max frequency to unity tasks.
####################################
write /proc/sys/kernel/sched_lib_name "com.miHoYo., com.activision., UnityMain, libunity.so, libil2cpp.so"
write /proc/sys/kernel/sched_lib_mask_force 255

exit 0