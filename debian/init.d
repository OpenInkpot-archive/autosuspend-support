#! /bin/sh

DESC="autosuspend"
NAME="autosuspend-support"
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

[ -f /etc/default/autosuspend ] && . /etc/default/autosuspend

set_timeout() {
	if [ x"$AUTOSUSPEND_TIMEOUT" != x ]; then
		echo $AUTOSUSPEND_TIMEOUT > /sys/power/autosuspend_timeout
	fi
}

case "$1" in
	start)
		echo -n "Starting $DESC: "
        set_timeout
		echo 1 > /sys/power/autosuspend
		echo "$NAME."
		;;
	stop)
		echo -n "Stopping $DESC: "
		echo 0 > /sys/power/autosuspend
		echo "$NAME."
		;;
    force-reload)
        echo -n "Reloading $DESC: "
        set_timeout
        echo "$NAME."
        ;;
	*)
		echo "Usage: /etc/init.d/$NAME {start|stop|force-reload}" >&2
		exit 1
	    ;;
esac

exit 0
