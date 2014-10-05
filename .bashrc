#!/bin/sh

function myskel()
{
	echo 'This is myskel git __GIT_DESCRIBE'
	echo 'See https://github.com/kerolasa/myskel for latest version'
}

export FULLNAME='Sami Kerola'
export NAME=$FULLNAME
export EMAIL='kerolasa@iki.fi'

export USER=$(id -un)
export LOGNAME="${USER}"

# Remove existing path, add all possible random directories where
# commands are found on various systems.  Check the directories once
# and make path lookup quick, by skipping all non-directories (missing,
# not access, symlinks, etc) entries.
PATH=''
PATHTMP=(
	/home/src/util-linux
	"$HOME/bin"
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
for I in "${PATHTMP[@]}"; do
	if [ -d "$I" ] && [ ! -h "$I" ]; then
		if [ "x" = "x$PATH" ]; then
			export PATH="$I"
		else
			export PATH="$PATH:$I"
		fi
	fi
done
unset PATHTMP

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
if [ ! -d "${HOME}/.histories" ]; then
	mkdir "${HOME}/.histories"
fi
export HISTFILE="${HOME}/.histories/${USER}@${HOSTNAME}"
export HISTFILESIZE=100
export HISTSIZE=100
export JOETERM=vt100
export LESSCHARSET=iso8859
# Solaris cluster manuals
if [ -d /usr/cluster/man ]; then
	export MANPATH="${MANPATH}:/usr/cluster/man"
fi
export MOZ_DISABLE_PANGO=1
export PAGER=less
export TMOUT=1800
export TMPDIR="$HOME/tmp"
export cdspell=on
export dotglob=on

unset LS_COLORS

if [ "x${TERM}" = 'xxterm' ]; then
	export PS1='\[\033]0;\h\007\]\u@\h:\w '
else
	export PS1='\u@\h:\w '
fi

# Remove system /etc/bash_completion
#complete -r
if [ -f /etc/puppet/scripts/puppet-svn-bash-completion ]; then
	source /etc/puppet/scripts/puppet-svn-bash-completion
fi

unalias -a
alias cp='cp -i'
alias less='less -Qin'
alias ls='ls -Fb'
alias more='more -dp'
alias mv='mv -i'
alias rm='rm -i'
alias which='type -P'

#http_proxy="proxy.example.com:1234"
if [ "x" != "x$http_proxy" ]; then
	HTTP_PROXY=$http_proxy
	https_proxy=$http_proxy
	HTTPS_PROXY=$http_proxy
	export http_proxy HTTP_PROXY https_proxy HTTPS_PROXY
fi
# The $http_proxy could come from /etc/profile keep it separate from
# previous if clause.
if [ "x" != "x$http_proxy" ]; then
	alias links="links -http-proxy $http_proxy -https-proxy $http_proxy"
fi

if type -P rdesktop >/dev/null; then
	alias rdesktop='rdesktop -g 95%'
fi
if type -P rpm >/dev/null; then
	alias rpmarch='rpm -q --qf "%{n}-%{v}-%{r}.%{arch}\n"'
fi
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

cd "$HOME"

# EOF
