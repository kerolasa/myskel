#!/bin/bash
#
# One line description.
#
# Sami Kerola <kerolasa@iki.fi>

# Default settings, do not touch.
# The trap ERR and pipefail are bashisms, do not change shebang.
JOB_NAME="${0##*/}"
set -e
trap 'echo "$JOB_NAME: exit on error in line $LINENO"; exit 1' ERR
set -u
set -o pipefail

# Begin <do not touch>
# Report errors by email only when shell is not interactive.
if [ -t 1 ]; then
	# Terminal exists, user is running script manually.  Do
	# not initiate error reporting.
	trap 'echo "$0: exit on error"; exit 1' ERR
else
	OUTPUTFILE=$(mktemp "/tmp/$JOB_NAME.XXXXXXXXX")
	exec > "$OUTPUTFILE" 2>&1
	set -x
	MAILTO="system-admin-maillist@example.com"
	CRONJOBLOGDIR="/tmp/$JOB_NAME"
	SERVER=$(hostname -s)
	TIMESTAMP=$(date --iso=ns)
	trap "cat "$OUTPUTFILE" |
		mailx -s \"$SERVER: $JOB_NAME failed\" $MAILTO" ERR
	trap "mv \"$OUTPUTFILE\" \"$CRONJOBLOGDIR/$JOB_NAME.$TIMESTAMP\"" 0
	if [ ! -d "$CRONJOBLOGDIR" ]; then mkdir -p "$CRONJOBLOGDIR"; fi
	find "$CRONJOBLOGDIR" -name "$JOB_NAME.*" \
		-type f -mtime +7 -delete
fi
# End <do not touch>

# WRITE YOUR SCRIPT HERE

exit 0
# EOF
