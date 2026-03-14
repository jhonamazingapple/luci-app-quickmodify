#!/bin/sh

ACTION="$1"

random_hostname() {
	HEX="$(hexdump -n 3 -e '3/1 "%02X"' /dev/urandom 2>/dev/null)"
	[ -n "$HEX" ] || HEX="$(date +%s | tail -c 7)"
	uci set system.@system[0].hostname="OpenWrt-$HEX"
}

random_mac() {
	# 生成本地管理单播 MAC
	B1="$(hexdump -n 1 -e '1/1 "%02X"' /dev/urandom 2>/dev/null)"
	B2="$(hexdump -n 1 -e '1/1 "%02X"' /dev/urandom 2>/dev/null)"
	B3="$(hexdump -n 1 -e '1/1 "%02X"' /dev/urandom 2>/dev/null)"
	B4="$(hexdump -n 1 -e '1/1 "%02X"' /dev/urandom 2>/dev/null)"
	B5="$(hexdump -n 1 -e '1/1 "%02X"' /dev/urandom 2>/dev/null)"

	FIRST="$(printf '%02X' $(( (0x$B1 | 0x02) & 0xFE )))"
	NEW_MAC="$FIRST:$B2:$B3:$B4:$B5:$(hexdump -n 1 -e '1/1 "%02X"' /dev/urandom 2>/dev/null)"

	uci set network.lan.macaddr="$NEW_MAC"
}

if [ "$ACTION" = "random" ]; then
	random_hostname
	random_mac
	uci commit system
	uci commit network
	echo '{"result":"ok"}'
	exit 0
fi

echo '{"error":"unsupported action"}'
exit 1
