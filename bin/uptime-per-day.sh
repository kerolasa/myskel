#!/bin/bash
#
# A linux uptime per day based on wtmp files.  Because I start my laptop
# each working day and power it off at end of the day I can use the wtmp
# files to tell how long I have spent time in office.
#
# Sami Kerola <kerolasa@iki.fi>

outfile=$(mktemp /tmp/uptime.XXXXXXXXXXXXXX)

for i in /var/log/wtmp*; do
	last --time-format=iso --file $i
done |
awk '/^reboot/ {
	if (7 < NF) {
		gsub(/[()]/, "", $8)
		split($8, time, ":")
		session = ((time[1] * 60) + time[2]) * 60
		if (seconds[$7] < session)
			seconds[$7] = session
	}
} END {
	for (key in seconds) {
		split(key, date, "T")
		sum[date[1]] += seconds[key]
	}
	for (key in sum) {
		print key, sum[key]
	}
}' |
sort -n -o "$outfile"

gnuplot -p <<EOF
set timefmt "%Y-%m-%d"
set xdata time
set xtics timedate
set xtics format "%m-%d\n%Y"
set ytics time
set grid
set title "Uptime per day"
set terminal png giant medium size 1200,600
set output './uptime-per-day.png' 
plot "$outfile" using 1:2 with impulses lw 1 title "", \
     "$outfile" using 1:2 smooth bezier title ""
EOF

rm -f "$outfile"

exit 0
