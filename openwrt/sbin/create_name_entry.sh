#!/bin/sh
domain_name=$1
uci batch << EOI
set dhcp.$domain_name=domain
set dhcp.$domain_name.name="$domain_name"
set dhcp.$domain_name.ip="$2"
EOI
uci commit
