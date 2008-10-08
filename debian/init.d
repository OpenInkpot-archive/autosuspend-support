#! /bin/sh

DESC="support for autosuspend"
NAME="autosuspend-support"
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin


[ -f /etc/default/autosuspend ] && . /etc/default/autosuspend

case "$1" in
	start)
		echo -n "Starting $DESC: "
		if [ x"$AUTOSUSPEND_TIMEOUT" != x"" ]; then
			echo $AUTOSUSPEND_TIMEOUT > /sys/power/autosuspend_timeout
		fi
		echo 1 > /sys/power/autosuspend
		echo "$NAME."
		;;
	stop)
		echo -n "Stopping $DESC: "
		echo 0 > /sys/power/autosuspend
		echo "$NAME."
		;;
	*)
		N=/etc/init.d/$NAME
		echo "Usage: $N {start|stop}" >&2
		exit 1
	;;
esac

exit 0
