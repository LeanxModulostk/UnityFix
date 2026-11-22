#!/system/bin/sh
MODDIR=${0%/*}
CFG=/data/adb/unityfix
LOG=/storage/emulated/0/unityfix_log.txt
WATCH=300   # seconds to watch the values (5 minutes)
STEP=15     # seconds between checks

sleep 60
####################################
# UnityFix @modulostk [Telegram]
####################################

# Wait (max 2 min) for the internal storage; if it never shows up the log
# is kept in $CFG instead
n=0
while [ ! -d /storage/emulated/0/Android ] && [ "$n" -lt 24 ]; do
    sleep 5
    n=$((n + 1))
done
if [ ! -d /storage/emulated/0/Android ]; then
    mkdir -p "$CFG"
    LOG="$CFG/unityfix_log.txt"
fi

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $*" >> "$LOG" 2>/dev/null
}

# Values chosen in the WebUI (defaults if nothing was saved).
# They are read again on every check, so a change made in the WebUI
# while the script is watching is never reverted.
load_cfg() {
    MASK=240
    LIBS="libunity.so, libfb.so"
    [ -f "$CFG/mask" ] && MASK=$(cat "$CFG/mask")
    [ -f "$CFG/libs" ] && LIBS=$(cat "$CFG/libs")
    case "$MASK" in
        ''|*[!0-9]*) MASK=240 ;;
    esac
}

apply_all() {
    #Libs names
    for f in /proc/sys/*/sched_lib_name; do
        [ -f "$f" ] && echo "$LIBS" > "$f"
    done
    #cores for the libs
    for f in /proc/sys/*/sched_lib_mask_force; do
        [ -f "$f" ] && echo "$MASK" > "$f"
    done
}

show_state() {
    for f in /proc/sys/*/sched_lib_mask_force /proc/sys/*/sched_lib_name; do
        [ -f "$f" ] && log "$1 $f = '$(cat "$f" 2>/dev/null)'"
    done
}

# Compare the kernel values with the WebUI ones and fix what changed
check_fix() {
    for f in /proc/sys/*/sched_lib_mask_force; do
        [ -f "$f" ] || continue
        cur=$(cat "$f" 2>/dev/null)
        if [ "$cur" != "$MASK" ]; then
            echo "$MASK" > "$f"
            log "MISMATCH $f: was '$cur', expected '$MASK' -> re-applied (now '$(cat "$f" 2>/dev/null)')"
        fi
    done
    for f in /proc/sys/*/sched_lib_name; do
        [ -f "$f" ] || continue
        cur=$(cat "$f" 2>/dev/null)
        if [ "$cur" != "$LIBS" ]; then
            echo "$LIBS" > "$f"
            log "MISMATCH $f: was '$cur', expected '$LIBS' -> re-applied (now '$(cat "$f" 2>/dev/null)')"
        fi
    done
}

# New log on every boot
: > "$LOG" 2>/dev/null

load_cfg
log "UnityFix started. Expected: mask='$MASK' libs='$LIBS'"
show_state "Before apply:"
apply_all
log "Values applied"
show_state "After apply:"

log "Watching for ${WATCH}s (every ${STEP}s)"
end=$(( $(date +%s) + WATCH ))
while [ "$(date +%s)" -lt "$end" ]; do
    sleep "$STEP"
    load_cfg
    check_fix
done

log "Watch finished (${WATCH}s)"
show_state "Final:"

exit 0
