SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=false
LATESTARTSERVICE=true

print_modname() {
  ui_print "*****************************************"
  ui_print "*   o   o         o       o--o          *"
  ui_print "*   |   |      o  |       |    o        *"
  ui_print "*   |   | o-o    -o- o  o O-o    \ /    *"
  ui_print "*   |   | |  | |  |  |  | |    |  o     *"
  ui_print "*    o-o  o  o |  o  o--O o    | / \.   *"
  ui_print "*                      |                *"
  ui_print "*                   o--o                *"
  ui_print "*                                       *"
  ui_print "*            🅼🅾🅳🆄🅻🅾🆂🆃🅺            *"
  ui_print "*               [Telegram]              *"
    ui_print "*               @modulostk              *"
  ui_print "*****************************************"
}

MOD_EXTRACT() {
 unzip -o "$ZIPFILE" system/* -d $MODPATH >&2
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
}