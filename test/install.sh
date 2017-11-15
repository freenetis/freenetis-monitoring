#!/bin/sh

set -e

if [ $# -lt 1 ]; then
	echo "usage: $0 DEB"
	exit 2
fi

DEB="$1"
UNIT=/etc/init.d/freenetis-monitoring

export DEBIAN_FRONTEND=noninteractive

echo "Install deb package"
apt-get update -q
if [ "$2" == "old" ]; then
	echo "Old style installation"
	dpkg -i "$DEB" || apt-get install -q -y -f
else
	apt install -q -y "$DEB"
fi

echo "Daemon test"
$UNIT version
$UNIT status | grep "FreenetIS monitor daemon is not running."
$UNIT start | grep "Starting FreenetIS monitor daemon: OK"
$UNIT status | grep "FreenetIS monitor daemon is running."
$UNIT stop | grep "Stopping FreenetIS monitor daemon: OK"
$UNIT status | grep "FreenetIS monitor daemon is not running."
