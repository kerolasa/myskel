#!/bin/sh

function myskel()
{
	echo "This is myskel git __GIT_DESCRIBE"
	echo "See https://github.com/kerolasa/myskel for latest version"
}

export FULLNAME="Sami Kerola"
export NAME=$FULLNAME
export EMAIL='kerolasa@iki.fi'

# Remove existing path, add all possible random directories where
# commands are found on various systems, check them once and make path
# lookup quick by skipping all non-directory (missing, not access, etc)
# entries.
PATH=''
PATHTMP=(
	/home/src/util-linux
	${HOME}/bin
	/usr/local/bin
	/usr/local/sbin
	/bin
	/usr/bin
	/sbin
	/usr/sbin
	/usr/java/jdk/bin
	/usr/lib/java/bin
	/usr/kerberos/bin
	/usr/kerberos/sbin
	/usr/bin/core_perl
	/usr/X11R6/bin
	/usr/gnu/bin
	/opt/sfw/bin
	/usr/proc/bin
	/usr/openwin/bin
	/usr/ucb
)
for I in ${PATHTMP[@]}; do
	if [ -d "$I" ]; then
		if [ "x" = "x$PATH" ]; then
			export PATH=$I
		else
			export PATH=$PATH:$I
		fi
	fi
done

#export LD_LIBRARY_PATH=
#export LD_LIBRARY_PATH_64=
export LANG=C
export LC_ALL=C

export BROWSER=firefox
export EDITOR=joe
export GZIP='-9'
export FCEDIT=${EDITOR}
export VISUAL=${EDITOR}
export HISTCONTROL=ignoreboth
export USER=$(id -un)
export HISTFILE=${HOME}/.histories/${USER}@${HOSTNAME}
if [ ! -d ${HOME}/.histories ]; then
	mkdir ${HOME}/.histories
fi
export HISTFILESIZE=100
export HISTSIZE=100
export JOETERM=vt100
export LESSCHARSET=iso8859
export LOGNAME=${USER}
# Solaris cluster man
#export MANPATH=${MANPATH}:/usr/cluster/man
export MOZ_DISABLE_PANGO=1
export PAGER=less
export TMOUT=1800
export TMPDIR=/tmp
export cdspell=on
export dotglob=on

unset LS_COLORS

if [ "x${TERM}" = "xxterm" ]; then
	export PS1="\[\033]0;\h\007\]\u@\h \w "
else
	export PS1="\u@\h \w "
fi

# The `complete -r' will disable /etc/bash_completion
complete -r

unalias -a
alias cp='cp -i'
alias less="less -Qin"
alias ls="ls -Fb"
alias more="more -dp"
alias mv='mv -i'
alias rm='rm -i'
alias which="type -path"
alias rpmarch='rpm -q --qf "%{n}-%{v}-%{r}.%{arch}\n"'
alias rpmspecdate='date +"* %a %b %d %Y  ${FULLNAME} <${EMAIL}>"'
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s dotglob
shopt -s extglob 
shopt -s huponexit

# If interactive terminal.
if [ -t 1 ]; then
	stty sane
	stty erase ^H
	stty erase ^?
	stty stop ''
	stty pass8
	set -C
	set -b
	set -u
fi

umask 022
ulimit -c unlimited

# EOF
