#!/system/bin/sh
while [[ "$(getprop sys.boot_completed)" != 1 ]] && [[ ! -d "/sdcard" ]]
do
sleep 1
done

sleep 60

write() {
if [[ -e $1 ]] && [[ $(cat $1) != $2 ]]
then
echo $2 > $1
fi
}

write /proc/sys/kernel/sched_lib_name "com.miHoYo., com.activision., UnityMain, libunity.so, libil2cpp.so"
write /proc/sys/kernel/sched_lib_mask_force 255
