#!/bin/bash
set -x

IPATH=/usr/local/share/p2sh

systemctl disable --now p2sh-mlat
systemctl disable --now p2sh-mlat2 &>/dev/null
systemctl disable --now p2sh-feed

if [[ -d /usr/local/share/tar1090/html-p2sh ]]; then
    bash /usr/local/share/tar1090/uninstall.sh p2sh
fi

rm -f /lib/systemd/system/p2sh-mlat.service
rm -f /lib/systemd/system/p2sh-mlat2.service
rm -f /lib/systemd/system/p2sh-feed.service

cp -f "$IPATH/p2sh-uuid" /tmp/p2sh-uuid
rm -rf "$IPATH"
mkdir -p "$IPATH"
mv -f /tmp/p2sh-uuid "$IPATH/p2sh-uuid"

set +x

echo -----
echo "p2sh.live feed scripts have been uninstalled!"
