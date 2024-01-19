#!/bin/bash

# Ort des Hauptskripts

# Entfernen des symbolischen Links
sudo rm -f /usr/bin/netcontrol

# Entfernen der Manpages
sudo rm -f /usr/local/man/man1/netcontrol.1
sudo rm -f /usr/share/man/man1/netcontrol.1
sudo mandb

# Entfernen des Crontab-Eintrags
(crontab -l | grep -v "netcontrol.sh") | crontab -

# Entfernen des Skripts
script_dir="$(dirname "$0")"
sudo rm -f "${script_dir}/netcontrol.sh"
sudo rm -f "${script_dir}/install_netcontrol.sh" 2> /dev/null

# Entfernen des Dateien in share
SCRIPT_PATH="/usr/share/netcontrol"
rm -f "$SCRIPT_PATH/netcontrol.sh"
rm -f "$SCRIPT_PATH/config.sh"
rm -f "$SCRIPT_PATH/log.log"
rm -f "$SCRIPT_PATH/hosts"

# Entfernen des uninstallscripts
rm -f "${script_dir}/uninstall_netcontrol.sh"


echo "Deinstallation von netcontrol abgeschlossen."

