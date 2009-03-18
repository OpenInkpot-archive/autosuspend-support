#! /bin/sh

DESC="autosuspend"
NAME="autosuspend-support"
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

SYS_CTL=/sys/power/autosuspend

[ -f /etc/default/autosuspend ] && . /etc/default/autosuspend

set_timeout() {
	if [ x"$AUTOSUSPEND_TIMEOUT" != x ]; then
		echo $AUTOSUSPEND_TIMEOUT > /sys/power/autosuspend_timeout
	fi
}

case "$1" in
	start)
		echo -n "Starting $DESC: "
        if [ -f $SYS_CTL ]; then
            set_timeout
		    echo 1 > $SYS_CTL
		    echo ok.
        else
            echo "not supported by kernel."
        fi
		;;
	stop)
		echo -n "Stopping $DESC: "
        if [ -f $SYS_CTL ]; then
		    echo 0 > /sys/power/autosuspend
		    echo ok.
        else
            echo "not supported by kernel."
        fi
		;;
    force-reload)
        echo -n "Reloading $DESC: "
        if [ -f $SYS_CTL ]; then
            set_timeout
            echo ok.
        else
            echo "not supported by kernel."
        fi
        ;;
	*)
		echo "Usage: /etc/init.d/autosuspend-support {start|stop|force-reload}" >&2
		exit 1
	    ;;
esac

exit 0
