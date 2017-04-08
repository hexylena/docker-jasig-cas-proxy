#!/bin/sh
set -ex

cat /etc/apache2/mods-enabled/auth_cas.conf.add >> /etc/apache2/mods-enabled/auth_cas.conf
sed -i "s/Listen 80/Listen ${LISTEN_PORT}/" /etc/apache2/ports.conf
service apache2 start
tail -f /var/log/apache2/* > /bin/startup.sh
