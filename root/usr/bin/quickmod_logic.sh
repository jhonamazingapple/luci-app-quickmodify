#!/bin/sh
gen_mac() {
    echo "00:E0:4C$(dd if=/dev/urandom bs=1 count=3 2>/dev/null | hexdump -e '3/1 ":%02X"')"
}
ACTION=$1
if [ "$ACTION" == "random" ]; then
    NEW_NAME="Router-$(random 100 999)"
    NEW_MAC=$(gen_mac)
    uci set system.@system[0].hostname="$NEW_NAME"
    uci set network.wan.macaddr="$NEW_MAC"
    [ "$(uci -q get quickmodify.main.diskless)" != "1" ] && uci set network.lan.macaddr="$NEW_MAC"
    uci commit
    /etc/init.d/system restart
    /etc/init.d/network restart
fi
