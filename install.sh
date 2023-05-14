SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false

print_modname() {
  ui_print "*******************************"
  ui_print "           MIUI 除草计划        "
  ui_print "           By MinaMiGo         "
  ui_print ""
  ui_print "       剃刀？感觉...不如除草！    "
  ui_print "*******************************"
}

REPLACE="
"

on_install() {
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2

  rm -f $MODPATH/system/simplify.conf

  if [ -e /system/product/priv-app/MIUIPackageInstaller ] ;then
    mkdir -p $MODPATH/system/product/priv-app/MIUIPackageInstaller
    mv $MODPATH/system/MIUIPackageInstaller.apk $MODPATH/system/product/priv-app/MIUIPackageInstaller/MIUIPackageInstaller.apk
    rm -rf /data/system/package_cache/*
    echo "persist.sys.allow_sys_app_update=true" >> $MODPATH/system.prop
    echo "已净化安装器"
    echo "rm -rf /data/system/package_cache/*" >> $MODPATH/uninstall.sh
  else
    echo "未检测到安装器 "
  fi
  rm -f $MODPATH/system/MIUIPackageInstaller.apk

  if [ -e /system/product/app/MSA ] ;then
    mkdir -p $MODPATH/system/product/app/MSA
    touch $MODPATH/system/product/app/MSA/MSA.apk
    echo "已精简广告组件"
  else
    echo "未检测到广告组件"
  fi

}

set_permissions() {
  set_perm_recursive  $MODPATH  0  0  0755  0644
}
