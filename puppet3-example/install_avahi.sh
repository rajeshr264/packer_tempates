#!/bin/sh 
# ref: http://www.youdidwhatwithtsql.com/avahi-mdns/2328/
set -u; 
function is_installed() { 
    PACKAGE="$1"; 
    yum list installed "$PACKAGE" >/dev/null ; return $? 
} 
is_installed epel-release || sudo yum install -y epel-release; 
is_installed avahi-dnsconfd || sudo yum install -y avahi-dnsconfd; 
is_installed avahi-tools || sudo yum install -y avahi-tools; 
is_installed nss-mdns || sudo yum install -y nss-mdns; 
sudo sed -i /etc/nsswitch.conf -e "/^hosts:*/c\hosts:\tfiles mdns4_minimal \[NOTFOUND=return\] dns myhostname" 
sudo service avahi-daemon start ;
