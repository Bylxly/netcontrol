#!/bin/bash

SCRIPT_PATH="/usr/share/netcontrol"

# Entfernen des symbolischen Links
sudo rm -f /usr/bin/netcontrol

# Entfernen der Manpages
sudo rm -f /usr/local/man/man1/netcontrol.1 &> /dev/null
sudo rm -f /usr/share/man/man1/netcontrol.1 &> /dev/null
sudo mandb &> /dev/null

# Entfernen des Crontab-Eintrags
crontab -l | grep -v "${script_dir}/netcontrol.sh" | crontab -

# Entfernen des Skripts
script_dir="$(dirname "$0")"
sudo rm -f "${script_dir}/netcontrol.sh"
sudo rm -f "${script_dir}/config.sh"
sudo rm -f "${script_dir}/install_netcontrol.sh" 2> /dev/null

# Entfernen des Dateien in share
rm -f "$SCRIPT_PATH/netcontrol.sh"
rm -f "$SCRIPT_PATH/config.sh"
rm -f "$SCRIPT_PATH/log.log"
rm -f "$SCRIPT_PATH/hosts"

# Entfernen des uninstallscripts
rm -f "${script_dir}/uninstall_netcontrol.sh"


echo "Deinstallation von netcontrol abgeschlossen."

