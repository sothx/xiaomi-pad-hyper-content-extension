# shellcheck disable=SC2148
# shellcheck disable=SC2034
SKIPUNZIP=0
source "$MODDIR"/util_functions.sh

if [[ "$KSU" == "true" ]]; then
  ui_print "- KernelSU 用户空间当前的版本号: $KSU_VER_CODE"
  ui_print "- KernelSU 内核空间当前的版本号: $KSU_KERNEL_VER_CODE"
else
  ui_print "- Magisk 版本: $MAGISK_VER_CODE"
  if [ "$MAGISK_VER_CODE" -lt 26000 ]; then
    ui_print "*********************************************"
    ui_print "! 请安装 Magisk 26.0+"
    abort "*********************************************"
  fi
fi

ui_print "- 正在为你修补传送门的权限，请稍等~"
patch_permissions


ui_print "- 好诶，《HyperOS For Pad 传送门补丁》安装/更新完成，重启系统后生效！"
