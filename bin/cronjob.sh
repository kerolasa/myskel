#!/bin/bash
#
# One line description.
#
# Your Name <your.name@example.com>

# Default settings, do not touch.
# The trap ERR and pipefail are bashisms, do not change shebang.
JOB_NAME=$(basename ${0})
set -e		# exit on errors
trap 'echo "${JOB_NAME}: exit on error"; exit 1' ERR
set -u		# disallow usage of unset variables
set -o pipefail	# make pipe writer failure to cause exit on error

# Begin <do not touch>
# Report errors by email only when shell is not interactive.
if [ -t 1 ]; then
	# Terminal exists, user is running script manually.  Do
	# not initiate error reporting.
	trap 'echo "${0}: exit on error"; exit 1' ERR
else
	OUTPUTFILE=$(mktemp /tmp/${JOB_NAME}/${JOB_NAME}.XXXXXX)
	exec > ${OUTPUTFILE} 2>&1
	set -x
	MAILTO="cron-errors@example.com"
	CRONJOBLOGDIR="/tmp/${JOB_NAME}"
	SERVER=$(hostname -s)
	TIMESTAMP=$(date +%s)
	trap "	cat ${OUTPUTFILE} |
			mail -s \"${SERVER}: ${JOB_NAME} failed\" ${MAILTO}" ERR
	trap "	if [ ! -d ${CRONJOBLOGDIR} ]; then
			mkdir -p ${CRONJOBLOGDIR}
		fi
	mv ${OUTPUTFILE} ${CRONJOBLOGDIR}/${JOB_NAME}.${TIMESTAMP}" 0
	find ${CRONJOBLOGDIR} -name "${JOB_NAME}.*" \
		-type f -mtime +7 -delete
fi
# End <do not touch>

# WRITE YOUR SCRIPT HERE

exit 0
# EOF
