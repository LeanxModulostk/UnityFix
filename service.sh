#!/system/bin/sh
MODDIR=${0%/*}

sleep 60

####################################
# UnityFix @modulostk [Telegram]
####################################
#Libs names
echo "libunity.so, libfb.so" > /proc/sys/kernel/sched_lib_name
echo "libunity.so, libfb.so" > /proc/sys/walt/sched_lib_name

#cores for the libs
echo "240" > /proc/sys/kernel/sched_lib_mask_force
echo "240" > /proc/sys/walt/sched_lib_mask_force

exit 0