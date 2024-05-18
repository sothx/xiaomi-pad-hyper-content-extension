# shellcheck disable=SC2148
# shellcheck disable=SC2034
SKIPUNZIP=0

SYSTEM_PRIVAPP_PERMISSION_PRODUCT_PATH=/system/product/etc/permissions/privapp-permissions-product.xml
MODULE_PRIVAPP_PERMISSION_PRODUCT_PATH="$MODDIR"/system/product/etc/permissions/privapp-permissions-product.xml
CODE_SNIPPET="$MODDIR"/common/code-snippet.xml

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

# 移除旧版补丁文件
rm -rf "$MODULE_PRIVAPP_PERMISSION_PRODUCT_PATH"

# 复制私有App权限配置到模块内
cp -f "$SYSTEM_PRIVAPP_PERMISSION_PRODUCT_PATH" "$MODULE_PRIVAPP_PERMISSION_PRODUCT_PATH"

# 拷贝权限代码片段到模块文件内
if [[ -f "$MODULE_PRIVAPP_PERMISSION_PRODUCT_PATH" ]]; then
  sed -i '/<\/permissions>/d' "$MODULE_PRIVAPP_PERMISSION_PRODUCT_PATH"
  cat "$CODE_SNIPPET" >> "$MODULE_PRIVAPP_PERMISSION_PRODUCT_PATH"
  printf "\n</permissions>\n" >> "$MODULE_PRIVAPP_PERMISSION_PRODUCT_PATH"
fi


ui_print "- 好诶，《HyperOS For Pad 传送门补丁》安装/更新完成，重启系统后生效！"
