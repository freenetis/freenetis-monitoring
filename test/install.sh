#!/bin/sh

set -e

if [ $# -ne 1 ]; then
	echo "usage: $0 DEB"
	exit 2
fi

DEB="$1"
UNIT=/etc/init.d/freenetis-monitoring

export DEBIAN_FRONTEND=noninteractive

echo "Install deb package"
apt-get update -q
apt install -y "$DEB"

echo "Daemon test"
$UNIT version
$UNIT status | grep "FreenetIS monitor daemon is not running."
$UNIT start | grep "Starting FreenetIS monitor daemon: OK"
$UNIT status | grep "FreenetIS monitor daemon is running."
$UNIT stop | grep "Stopping FreenetIS monitor daemon: OK"
$UNIT status | grep "FreenetIS monitor daemon is not running."
