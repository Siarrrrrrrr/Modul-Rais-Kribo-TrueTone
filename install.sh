#!/bin/sh

# shellcheck disable=SC2034

SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true

REPLACE="
"
sleep 2

ui_print ""
ui_print "************************************"
ui_print "*    MrKriboo @ MrKriboo   *"
ui_print "************************************"
ui_print "*      MrKriboo @ MrKrboo     *"
ui_print "************************************"
ui_print ""

ui_print ""
ui_print "************************************"
ui_print "*   Contributor : RiProG Open Source @ RiOpSo   *"
ui_print "************************************"
ui_print "*   Contributor :   Muhammad Rizki @ RiProG     *"
ui_print "************************************"
ui_print ""

ui_print ""
ui_print "************************************"
ui_print "*    Credit : @Dims_Camper   *"
ui_print "************************************"
ui_print "*      Thnks @Dims_Camper for sharing cinema display    *"
ui_print "************************************"
ui_print ""

kcal_1="/sys/devices/platform/kcal_ctrl.0"
kcal_2="$(find /sys/module/msm_drm/parameters/ -maxdepth 1 -type f -name 'kcal_*')"
if [ -d "$kcal_1" ]; then
    echo "Kernel supports enjoy truetone, Cinema Display and saturation boost."
elif [ -n "$kcal_2" ]; then
    echo "Kernel supports enjoy truetone, Cinema Display and saturation boost."
else
    echo "Kernel does not support the kcal, only can run saturation boost."
    exit 0
fi
