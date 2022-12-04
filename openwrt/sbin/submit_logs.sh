#/bin/sh
echo "Wireless config" > /tmp/logs.txt
cat /etc/config/wireless >> /tmp/logs.txt
echo "Network config" >> /tmp/logs.txt
cat /etc/config/network >> /tmp/logs.txt
echo "ifconfig" >> /tmp/logs.txt
ifconfig >> /tmp/logs.txt
echo "brctl show" >> /tmp/logs.txt
brctl show >> /tmp/logs.txt
echo "route" >> /tmp/logs.txt
route >> /tmp/logs.txt
echo "ifconfig -a" >> /tmp/logs.txt
ifconfig -a >> /tmp/logs.txt
echo "DHCP config" >> /tmp/logs.txt
cat /etc/config/network >> /tmp/logs.txt
echo "logread" >> /tmp/logs.txt
logread >> /tmp/logs.txt
echo "Wireless clients" >> /tmp/logs.txt
iw wlan0 station dump >> /tmp/logs.txt
iw wlan0-1 station dump >> /tmp/logs.txt
iw wlan1 station dump >> /tmp/logs.txt
iw wlan1-1 station dump >> /tmp/logs.txt
iw wlan1-2 station dump >> /tmp/logs.txt
echo "Nebula logs" >> /tmp/logs.txt
cat /etc/nearhop/logs/logs.txt >> /tmp/logs.txt
echo "unum logs" >> /tmp/logs.txt
cat /var/log/unum.log >> /tmp/logs.txt
echo "unum http logs" >> /tmp/logs.txt
cat /var/log/http.log >> /tmp/logs.txt
echo "aconfig.yml" >> /tmp/logs.txt
cat /etc/nearhop/configs/aconfig.yml >> /tmp/logs.txt
echo "bconfig.yml" >> /tmp/logs.txt
cat /etc/nearhop/configs/bconfig.yml >> /tmp/logs.txt
echo "All clients" >> /tmp/logs.txt
cat cat /etc/nearhop/clients/* >> /tmp/logs.txt
