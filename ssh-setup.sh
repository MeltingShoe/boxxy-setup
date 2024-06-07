#!/usr/bin/env bash

apt update
apt upgrade

apt install openssh-server

ufw enable

echo "enter desired port"
read
echo "port is $REPLY/tcp"

ufw allow $REPLY/tcp

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i "/Port/c\Port $REPLY" /etc/ssh/sshd_config
sed -i "/PasswordAuthentication/c\PasswordAuthentication no" /etc/ssh/sshd_config
mkdir -p ~/.ssh
cp authorized_keys ~/.ssh/authorized_keys


systemctl restart ssh

systemctl status ssh
