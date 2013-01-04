#!/bin/bash
#
# One line description.
#
# Sami Kerola <kerolasa@iki.fi>

# Uncomment if you need to debug.
#set -x
# Uncomment if you want to get rid of all output.
#exec > /dev/null 2>&1

# Default settings, do not touch.
SCRIPT_INVOCATION_SHORT_NAME=${0##*/}
set -e		# exit on errors
# trap ERR is bashism, do not change shebang!
trap 'echo "${SCRIPT_INVOCATION_SHORT_NAME}: exit on error"; exit 1' ERR
set -u		# disallow usage of unset variables
set -o pipefail	# make pipe writer failure to cause exit on error
RETVAL=0

# Use this function when you want to inform user about something.
# If you don't want to get script name in front of the message,
# which would be a bit strange, use normal echo.
msg() {
	echo "${SCRIPT_INVOCATION_SHORT_NAME}: ${@}"
}

usage() {
	echo "Usage:"
	echo " ${0} [-hV] [argument ...]"
	echo ""
	echo " -h   display this help and exit"
	echo " -V   output version information and exit"
	exit ${1}
}

#MANDATORYB=0
#while getopts a:bhV OPTIONS; do
while getopts hV OPTIONS; do
	case ${OPTIONS} in
#		a)
#			msg "-a ${OPTARG}"
#			;;
#		b)
#			msg "-b"
#			MANDATORYB=1
#			;;
		h)
			usage 0
			;;
		V)
			# With subversion
			#svn propset svn:keywords Revision generic.sh
			#msg '$Revision:$'
			# When git, use post commit hook, or
			# simply maintain a number
			msg '0.1'
			exit 0
			;;
		*)
			usage 1
			;;
	esac
done
#shift $((OPTIND-1))
# Make sure there is at least one argument.
#if [ ${#} -eq 0 ]; then
#	usage 1
#fi
#if [ "x0" = "x${MANDATORYB}" ]; then
#	msg "mandatory argument is missing."
#	usage 1
#fi

# INSERT HERE DRAGONS

exit ${RETVAL}
# EOF
