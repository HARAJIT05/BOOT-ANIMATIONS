#dont edit any of this 

# remount system as r/w
mount -o rw,remount /system


# remount vendor as r/w
mount -o rw,remount /vendor

# remove miui camera flag
mv /vendor/etc/init/hw/init.qcom.bak /vendor/etc/init/hw/init.qcom.rc

# Don't modify anything after this
if [ -f $INFO ]; then
  while read LINE; do
    if [ "$(echo -n $LINE | tail -c 1)" == "~" ]; then
      continue
    elif [ -f "$LINE~" ]; then
      mv -f $LINE~ $LINE
    else
      rm -f $LINE
      while true; do
        LINE=$(dirname $LINE)
        [ "$(ls -A $LINE 2>/dev/null)" ] && break 1 || rm -rf $LINE
      done
    fi
  done < $INFO
  rm -f $INFO
fi
