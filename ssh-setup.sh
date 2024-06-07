#!/usr/bin/env bash

apt update
apt upgrade

apt install openssh-server

ufw enable

echo "enter desired port"
read
echo "port is $REPLY/tcp"

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i "/Port/c\Port $REPLY" /etc/ssh/sshd_config
sed -i "/PasswordAuthentication/c\PasswordAuthentication no" /etc/ssh/sshd_config
cat /etc/ssh/sshd_config
mkdir -p ~/.ssh
cp authorized_keys ~/.ssh/authorized_keys

ufw allow $REPLY/tcp

systemctl disable --now ssh.socket
systemctl enable --now ssh.service

systemctl restart ssh



systemctl status ssh
