# shellcheck disable=SC2148
# shellcheck disable=SC2034
SKIPUNZIP=0

NODULE_MIUIContentExtension_APK_PATH=$MODPATH/system/product/priv-app/MIUIContentExtension/MIUIContentExtension.apk
SYSTEM_NODULE_MIUIContentExtension_APK_PATH=/system/product/priv-app/MIUIContentExtension/MIUIContentExtension.apk

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



ui_print "- 正在为你安装传送门，请稍等~"

pm install -r -f  $NODULE_MIUIContentExtension_APK_PATH
HAS_BEEN_INSTALLED_MIUIContentExtension_APK=$(pm list packages | grep com.miui.contentextension)
sleep 6
if [[ $HAS_BEEN_INSTALLED_MIUIContentExtension_APK == *"package:com.miui.contentextension"* ]]; then
  ui_print "- 已经完成传送门的安装，正在修补传送门的相关权限~"
  pm grant com.miui.contentextension android.permission.WRITE_SECURE_SETTINGS
  ui_print "- 好诶，《HyperOS For Pad 传送门补丁》安装/更新完成，重启系统后生效！"
else
  ui_print "- 坏诶，《HyperOS For Pad 传送门补丁》安装失败，请尝试重新安装！"
fi
