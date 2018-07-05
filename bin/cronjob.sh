#!/bin/bash
# The trap ERR and various settings are bashisms, do not change shebang.
#
# One line description.
#
# Sami Kerola <kerolasa@iki.fi>

# Begin <do not touch>
declare -r JOB_NAME="${0##*/}"
set -e
trap 'echo "$JOB_NAME: exit on error in line $LINENO" >&2; exit 1' ERR
set -o errtrace
set -o noclobber
set -o nounset
set -o pipefail
# Report errors by email only when shell is not interactive.
if ! [ -t 1 ]; then
	declare -r OUTPUTFILE=$(mktemp "/tmp/$JOB_NAME.XXXXXXXXX")
	exec 1> "$OUTPUTFILE" 2>&1
	set -o xtrace
	declare -r MAILTO="system-admin-maillist@example.com"
	declare -r CRONJOBLOGDIR="/tmp/$JOB_NAME"
	declare -r TIMESTAMP="$(date --iso=ns)"
	trap "cat $OUTPUTFILE |
		mailx -s \"$HOSTNAME: $JOB_NAME failed\" $MAILTO" ERR
	trap 'mv "$OUTPUTFILE" "$CRONJOBLOGDIR/$JOB_NAME.$TIMESTAMP"' EXIT
	if [ ! -d "$CRONJOBLOGDIR" ]; then mkdir -p "$CRONJOBLOGDIR"; fi
	find "$CRONJOBLOGDIR" -name "$JOB_NAME.*" \
		-type f -mtime +7 -delete
fi
# End <do not touch>

# WRITE YOUR SCRIPT HERE

exit 0
# EOF
