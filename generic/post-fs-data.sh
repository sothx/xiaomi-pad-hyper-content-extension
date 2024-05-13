# shellcheck disable=SC2148

MODDIR=${0%/*}

SYSTEM_PRIVAPP_PERMISSION_PRODUCT_PATH=/system/product/etc/permissions/privapp-permissions-product.xml
MODULE_PRIVAPP_PERMISSION_PRODUCT_PATH="$MODDIR"/system/product/etc/permissions/privapp-permissions-product.xml
CODE_SNIPPET="$MODDIR"/common/code-snippet.xml

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