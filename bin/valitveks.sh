#!/bin/bash
#
# Remove white spaces and tabs from file names.
# Sami Kerola <kerolasa@iki.fi>

set -eu
trap 'echo "${0##*/}: exit on error"; exit 1' ERR

for I in "$@"; do
	FILE="${I##*/}"
	FILE=$(echo $FILE | tr ' 	' '__')
	if [ "${I##*/}" = "$FILE" ]; then
		continue
	fi
	if [ "${I/\/}"  = "$I" ]; then
		mv --verbose --interactive "$I" "$FILE"
	else
		mv --verbose --interactive "$I" "${I%/*}/$FILE"
	fi
done

exit 0
