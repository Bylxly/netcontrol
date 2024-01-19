#installieren der man page
sudo cp netcontrol.1 /usr/local/man/man1/netcontrol.1
sudo cp netcontrol.1 /usr/share/man/man1/netcontrol.1
sudo mandb
rm -f netcontrol.1

#ausführbar machen
chmod +x netcontrol.sh
chmod +x uninstall_netcontrol.sh

#kopieren nach share
SCRIPT_PATH="/usr/share/netcontrol"
sudo mkdir "$SCRIPT_PATH"
sudo cp netcontrol.sh "$SCRIPT_PATH"

sudo chmod -R 777 "$SCRIPT_PATH"

#erstellen des netcontrol links
sudo ln -s "$SCRIPT_PATH/netcontrol.sh" /usr/bin/netcontrol
sudo chown root:users /usr/bin/netcontrol
sudo chmod +x /usr/bin/netcontrol

#falls user ping nicht ausführen kann
sudo setcap cap_net_raw+ep /bin/ping

# Entfernen des installscripts
script_dir="$(dirname "$0")"
rm -f "${script_dir}/install_netcontrol.sh"
