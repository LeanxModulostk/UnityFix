# UnityFix

**English** | [Español](#español)

![](https://i.ibb.co/bvcBtGQ/1670234941155.png)

## Description
Applications that use the Unity engine incorrectly set the CPU affinity to maximum capacity cores, this module configures the library name and mask to always report the same maximum which helps improve performance in games such as:
- Call of Duty Mobile
- Genshin Impact
- League of Legends: Wild Rift
- Mobile Legends
- CarX Street
- Free Fire
- and others...

- **You can add the library for a game or app via the web UI.**

### How it works
UnityFix sets two kernel parameters (in `/proc/sys/kernel/` or `/proc/sys/walt/`, depending on the kernel):

- **`sched_lib_name`**: Comma-separated list of library names (.so), for example `libunity.so, libfb.so`. The kernel checks the libraries each app has loaded, and if one of them matches a name in the list, the app is treated as a "library based app". Unity games load `libunity.so`.
- **`sched_lib_mask_force`**: CPU bitmask (bit N = CPU N, an integer between 0 and 255). When one of the apps detected through `sched_lib_name` asks the kernel to pin its threads to some cores, the kernel replaces the cores it asked for with this mask.

Mask values (8 cores):

| Value | CPUs |
|---|---|
| 255 | All cores [0-7] |
| 240 | 4 cores [4-7] |
| 192 | 2 cores [6-7] |
| 128 | Only CPU 7 |

The module applies your values at every boot and you can change them from the WebUI: the core buttons set `sched_lib_mask_force` and the Libraries section edits `sched_lib_name`. The kernel limits the length of the library list (usually 512 characters), and the exact behavior can vary slightly between kernel versions.

## Installation
1. Flash the module in Magisk / KernelSU
2. Reboot
3. Enjoy!

The installer checks that your kernel has `/proc/sys/*/sched_lib_mask_force`. If it does not, the installation is cancelled because the kernel is not supported.

## Log
After each boot the module watches `sched_lib_mask_force` and `sched_lib_name` for 5 minutes. Some ROMs reset these values after boot, so if they stop matching what you set in the WebUI, the module applies them again.

Every step is saved with date and time (hour, minutes and seconds) in `/storage/emulated/0/unityfix_log.txt`: the values before and after applying, each change detected and the final values. A new log is created on every boot. If the internal storage is not available, it is saved in `/data/adb/unityfix/unityfix_log.txt`.

## Tip
To see the native libraries (`.so`) of your app (game), the [LibChecker](https://github.com/LibChecker/LibChecker) app is recommended. You can add the ones you need from the WebUI (Libraries).

## Support
- [GitHub](https://github.com/LeanxModulostk/UnityFix) 
- [Telegram Channel](https://t.me/modulostk)

## Extras
- Donations: [PayPal](https://www.paypal.me/LeanHijosdesusMadres) - [LiberaPay](https://liberapay.com/LeanHijosdesusMadres) - [Ko-fi](https://ko-fi.com/leantupapi) - [Binance](https://app.binance.com/qr/dplk7b28e9c123ff4e378b472505b0adba63) - [SociaBuzz](https://sociabuzz.com/leanhijosdesusmadres/support) - [More](https://t.me/modulemagiskChiase/4846)

## Special Thanks

- [Jimmy Shiu](https://android.googlesource.com/device/google/sunfish/+/446024a^!/)
- [alanndz authored and NotZeetaa committed](https://github.com/NotZeetaa/device_xiaomi_sm8250-common-4/commit/f9cb3ad1fb850e0c80d0f7684a4b4b1643aa6b41)
- [Zackptg5](https://github.com/Zackptg5) for the MMT-Ex template
- [Topjohnwu](https://github.com/topjohnwu) for making Magisk


---

# Español

[English](#unityfix) | **Español**

## Descripción
Las aplicaciones que usan el motor Unity configuran incorrectamente la afinidad de la CPU a los núcleos de capacidad máxima, este módulo configura el nombre de la biblioteca y la máscara para reportar siempre el mismo máximo lo que ayuda a mejorar el rendimiento en juegos como:
- Call of Duty Mobile
- Genshin Impact
- League of Legends: Wild Rift
- Mobile Legends
- CarX Street
- Free Fire
- y otros...

- **Se puede añadir la librería de algún juego o app mediante el WebUI.**

### Cómo funciona
UnityFix configura dos parámetros del kernel (en `/proc/sys/kernel/` o `/proc/sys/walt/`, según el kernel):

- **`sched_lib_name`**: Lista de nombres de librerías (.so) separados por comas, por ejemplo `libunity.so, libfb.so`. El kernel revisa las librerías que cada app tiene cargadas y, si una coincide con un nombre de la lista, trata a la app como una "app basada en librería". Los juegos de Unity cargan `libunity.so`.
- **`sched_lib_mask_force`**: Máscara de bits de CPU (bit N = CPU N, un número entero entre 0 y 255). Cuando una de las apps detectadas mediante `sched_lib_name` le pide al kernel fijar sus hilos a ciertos núcleos, el kernel reemplaza los núcleos que pidió por esta máscara.

Valores de la máscara (8 núcleos):

| Valor | CPUs |
|---|---|
| 255 | Todos los núcleos [0-7] |
| 240 | 4 núcleos [4-7] |
| 192 | 2 núcleos [6-7] |
| 128 | Solo la CPU 7 |

El módulo aplica tus valores en cada arranque y puedes cambiarlos desde el WebUI: los botones de núcleos configuran `sched_lib_mask_force` y la sección Librerías edita `sched_lib_name`. El kernel limita el largo de la lista de librerías (normalmente 512 caracteres) y el comportamiento exacto puede variar un poco entre versiones del kernel.

## Instalación
1. Flashea el módulo en Magisk / KernelSU
2. Reinicia
3. ¡Disfruta!

El instalador comprueba que tu kernel tenga `/proc/sys/*/sched_lib_mask_force`. Si no lo tiene, la instalación se cancela porque el kernel no es compatible.

## Registro (log)
Después de cada arranque el módulo vigila `sched_lib_mask_force` y `sched_lib_name` durante 5 minutos. Algunas ROMs resetean estos valores después de arrancar, así que si dejan de coincidir con lo que configuraste en el WebUI, el módulo los vuelve a aplicar.

Cada paso se guarda con fecha y hora (horas, minutos y segundos) en `/storage/emulated/0/unityfix_log.txt`: los valores antes y después de aplicar, cada cambio detectado y los valores finales. Se crea un log nuevo en cada arranque. Si el almacenamiento interno no está disponible, se guarda en `/data/adb/unityfix/unityfix_log.txt`.

## Consejo
Para ver las librerías nativas (`.so`) de tu aplicación (juego) se recomienda la app [LibChecker](https://github.com/LibChecker/LibChecker). Puedes agregar las que necesites desde el WebUI (Librerías).

## Soporte
- [GitHub](https://github.com/LeanxModulostk/UnityFix)
- [Canal de Telegram](https://t.me/modulostk)

## Extras
- Donaciones: [PayPal](https://www.paypal.me/LeanHijosdesusMadres) - [LiberaPay](https://liberapay.com/LeanHijosdesusMadres) - [Ko-fi](https://ko-fi.com/leantupapi) - [Binance](https://app.binance.com/qr/dplk7b28e9c123ff4e378b472505b0adba63) - [SociaBuzz](https://sociabuzz.com/leanhijosdesusmadres/support) - [Más](https://t.me/modulemagiskChiase/4846)

## Agradecimientos especiales

- [Jimmy Shiu](https://android.googlesource.com/device/google/sunfish/+/446024a^!/)
- [alanndz authored and NotZeetaa committed](https://github.com/NotZeetaa/device_xiaomi_sm8250-common-4/commit/f9cb3ad1fb850e0c80d0f7684a4b4b1643aa6b41)
- [Zackptg5](https://github.com/Zackptg5) for the MMT-Ex template
- [Topjohnwu](https://github.com/topjohnwu) for making Magisk
