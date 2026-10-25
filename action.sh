#!/system/bin/sh
BASEDIR="$(dirname $(readlink -f "$0"))"
FILE="/data/adb/modules/unityfix/service.sh"
A0="/storage/emulated/0"

echo "============================="
echo "       UnityFix"
echo "============================="
echo ""
echo "How many cores do you want Unity libs to use?:
Vol+ = Use all cores [0-7]
Vol- = Use 4 cores [4-7]
Touch Screen = Use 2 cores [6-7]"
echo ""

# =========================================
# Esperar interacción del usuario (Vol+, Vol-, Touch)
# =========================================
wait_timeout=10  # segundos máximo de espera
while true; do
    if read -r -t "$wait_timeout" LINE < <(getevent -ql); then
        # Detectar Vol+
        if echo "$LINE" | grep -q "KEY_VOLUMEUP.*DOWN"; then
            CURRENT=$(cat /proc/sys/kernel/sched_lib_mask_force 2>/dev/null || echo 0)
            if [ "$CURRENT" != "255" ]; then
                sed -i 's/240/255/g' "$FILE"
                sed -i 's/192/255/g' "$FILE"
                for f in /proc/sys/*/sched_lib_mask_force; do
                    [ -f "$f" ] && echo 255 > "$f"
                done
                echo "UnityFix: Use all cores for Unity libs"
            else
                echo "UnityFix: No change it was already applied"
            fi
            break
        fi

        # Detectar Vol-
        if echo "$LINE" | grep -q "KEY_VOLUMEDOWN.*DOWN"; then
            CURRENT=$(cat /proc/sys/kernel/sched_lib_mask_force 2>/dev/null || echo 0)
            if [ "$CURRENT" != "240" ]; then
                sed -i 's/255/240/g' "$FILE"
                sed -i 's/192/240/g' "$FILE"
                for f in /proc/sys/*/sched_lib_mask_force; do
                    [ -f "$f" ] && echo 240 > "$f"
                done
                echo "UnityFix: Use 4 cores for Unity libs"
            else
                echo "UnityFix: No change it was already applied"
            fi
            break
        fi

        # Si no es Vol+ ni Vol-, consideramos cualquier otra interacción como Touch
        CURRENT=$(cat /proc/sys/kernel/sched_lib_mask_force 2>/dev/null || echo 0)
        if [ "$CURRENT" != "192" ]; then
            sed -i 's/240/192/g' "$FILE"
            sed -i 's/255/192/g' "$FILE"
            for f in /proc/sys/*/sched_lib_mask_force; do
                [ -f "$f" ] && echo 192 > "$f"
            done
            echo "UnityFix: Use 2 cores for Unity libs (Touch Screen)"
        else
            echo "UnityFix: No change it was already applied"
        fi
        break
    fi
done

# ========================
# Continuar con el resto del script
# ========================

echo ""
echo "============================="
echo "+ By：@LeanHijosdesusMadres"
echo "============================="

echo "libunity.so, libfb.so" > /proc/sys/kernel/sched_lib_name
echo "libunity.so, libfb.so" > /proc/sys/walt/sched_lib_name

sleep 3

# Enviar notificación (sin imprimir nada)
su -lp 2000 -c "cmd notification post -S bigtext -t 'Sex?:' -i file:///storage/emulated/0/Android/media/.lean.png -I file:///storage/emulated/0/Android/media/.modulostk.png lean '@LeanHijosdesusMadres'" >/dev/null 2>&1

# Copiar imagen si no existe (sin imprimir nada)
#[ ! -f "$A0/lean.jpg" ] && cp "$BASEDIR/lean.jpg" "$A0/" >/dev/null 2>&1

# Abrir imagen en la galería (sin imprimir nada)
#[ -f "$A0/lean.jpg" ] && su -c "am start -a android.intent.action.VIEW -d file://$A0/lean.jpg -t image/jpeg" >/dev/null 2>&1