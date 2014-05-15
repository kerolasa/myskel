#!/bin/bash
#
# Remove white spaces and tabs from file names.
# Sami Kerola <kerolasa@iki.fi>

set -eu
trap 'echo "${0##*/}: exit on error"; exit 1' ERR

for I in "$@"; do
	FILE="${I##*/}"
	FILE=${FILE/ /_}
	FILE=${FILE/	/_}
	if [ "${I##*/}" = "$FILE" ]; then
		continue
	fi
	mv --verbose --interactive "$I" "${I%/*}/$FILE"
done

exit 0
