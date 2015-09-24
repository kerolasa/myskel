#!/bin/bash
#
# Dump a history of running bash.

if [ $# -eq 0 ]; then
	echo "usage: $0 <bash_pid>"
	exit 1
fi
gdb -batch \
	--eval "set sysroot /" \
	--eval "attach $1" \
	--eval "call write_history(\"/tmp/bash_history-$1.txt\")" \
	--eval 'detach' \
	--eval 'q'
exit 0
