#!/bin/bash
#
# One line description.
#
# Sami Kerola <sami.kerola@tomtom.com>

# Uncomment if you need to debug.
#set -x
# Uncomment if you want to get rid of all output.
#exec > /dev/null 2>&1

# Default settings, do not touch.
SCRIPT_INVOCATION_SHORT_NAME=$(basename ${0})
set -e # exit on errors
# trap ERR is bashism, do not change shebang!
trap 'echo "${SCRIPT_INVOCATION_SHORT_NAME}: exit on error"; exit 1' ERR
set -u # disallow usage of unset variables
RETVAL=0

# Write functions to this section.
#
# Use this function when you want to inform user about something.
# If you don't want to get script name in front of the message,
# which would be a bit strange, use normal echo.
msg() {
	echo "${SCRIPT_INVOCATION_SHORT_NAME}: ${@}"
}

usage() {
	echo "Usage: ${0} [-switches] [parameters]"
	exit ${1}
}

# Example getopts.
# Make sure there is at least one argument.
#if [ ${#} -eq 0 ]; then
#	usage 1
#fi
#MANDATORYB=0
#while getopts a:b? OPTIONS; do
#	case ${OPTIONS} in
#		a)
#			# Notice that colon in getopts line
#			# defines that the option has argument.
#			msg "-a ${OPTARG}"
#			;;
#		b)
#			msg "-b"
#			MANDATORYB=1
#			;;
#		\?)
#			usage 0
#			;;
#		*)
#			usage 1
#			;;
#	esac
#done
#shift $((OPTIND-1))
#if [ "x0" = "x${MANDATORYB}" ]; then
#	msg "mandatory argument is missing."
#	usage 1
#fi

# INSERT HERE DRAGONS

exit ${RETVAL}
# EOF
