#installieren der man page
sudo cp netcontrol.1 /usr/local/man/man1/netcontrol.1 2>&1 /dev/null
sudo cp netcontrol.1 /usr/share/man/man1/netcontrol.1 2>&1 /dev/null
sudo mandb 2>&1 /dev/null
rm -f netcontrol.1

#ausführbar machen
chmod +x netcontrol.sh
chmod +x uninstall_netcontrol.sh

#kopieren nach share
SCRIPT_PATH="/usr/share/netcontrol"
sudo mkdir "$SCRIPT_PATH" 2> /dev/null
sudo cp netcontrol.sh "$SCRIPT_PATH"
sudo mv config.sh "$SCRIPT_PATH"
sudo chmod -R 777 "$SCRIPT_PATH"

#erstellen des netcontrol links
sudo ln -s "$SCRIPT_PATH/netcontrol.sh" /usr/bin/netcontrol
sudo chown root:users /usr/bin/netcontrol
sudo chmod +x /usr/bin/netcontrol

#falls user ping nicht ausführen kann
sudo setcap cap_net_raw+ep /bin/ping



echo "Installation beendet!"
echo "Das Script ist unter dem Command netcontrol erreichbar"


# Entfernen des installscripts
script_dir="$(dirname "$0")"
rm -f "${script_dir}/install_netcontrol.sh"
