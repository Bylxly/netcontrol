#!/bin/bash

#Ort der Config
script_dir="/usr/share/netcontrol"
CONFIG_FILE="${script_dir}/config.sh"

#Ort der Liste der gespeicherten Hosts
HOSTS_FILE="${script_dir}/hosts"

#Ort des Logs
LOG_FILE="${script_dir}/log.log"

#prüft ob hostsfile existert; erstellt eine neue falls nicht
if [ ! -f "$HOSTS_FILE" ]; then
	if ! touch "$HOSTS_FILE" 2> /dev/null; then
		touch "$HOSTS_FILE"
	fi
fi

#prüft ob configfile existiert; erstellt eine neue falls nicht
if [ ! -f "$CONFIG_FILE" ]; then
	echo -e "# Anzahl der Ping Versuche\ncount=1\n\n# Timeout nach wievielen sekunden\ntimeout=2\n\n# Zeit zwischen Intervallen\ninterval=3" > "$CONFIG_FILE"
fi

#import config
source "${CONFIG_FILE}"

#fügt einen host zur hostfile hinzu
add_host() {
	if ! grep -qx "$1" "$HOSTS_FILE"; then
		echo "$1" >> "$HOSTS_FILE"
	fi
}

#entfernt einen host aus der hostfile
del_host() {
	grep -v "^$1$" "$HOSTS_FILE" > temp | mv temp "$HOSTS_FILE"
}

#gibt alle hosts aus
print_hosts() {
	cat "$HOSTS_FILE"
}

#geht die liste der hosts durch und ping sie mit den einstellungen aus der config an
#falls der host nicht erreichbar ist wird ein fehler ausgegeben und in die log datei geschrieben
ping_hosts() {
	
	while read -r host; do
		if ! ping -c "$count" -W "$timeout" -i "$interval" "$host" &> /dev/null; then
			echo "["$(date -Iseconds)"] Der Host $host ist nicht erreichbar!" | tee -a "$LOG_FILE"
		fi
	done < "$HOSTS_FILE"
}

#installiert bzw. aktualisiert einen crontab 
install_cron() {
	(crontab -l 2>/dev/null; echo "*$1 * * * * "${script_dir}/netcontrol.sh"") | crontab -
}

#entfernt einen crontab
remove_cron() {
	crontab -l | grep -v "${script_dir}/netcontrol.sh" | crontab -
}

case "$1" in
	addhost)
		add_host "$2"
	;;
	delhost)
		del_host "$2"
	;;
	printhosts)
		print_hosts
	;;
	install)
		install_cron "$2"
	;;
	uninstall)
		remove_cron
	;;
	*)
		ping_hosts
	;;
esac
