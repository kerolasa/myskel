#!/bin/bash
#
# My wrapper script to nuke multiple public keys in one go including IP
# address, short name and so on.  This script is especially useful in
# ssh gateway type of server.
#
# Sami Kerola <sami.kerola@sabre.com>

msg() {
	echo "removing $1"
}

for I in "$@"; do
	msg "$I"
	ssh-keygen -R "$I" 2>/dev/null
	for J in $(getent hosts "$I"); do
		msg "$J"
		ssh-keygen -R "$J" 2>/dev/null
	done
done

exit 0
