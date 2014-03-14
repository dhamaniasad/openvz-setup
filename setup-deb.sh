#!/bin/bash

# Check if being run as root

if [ $USER != 'root' ]; then
echo "Sorry, you need to run this script as root."
exit
fi

# Add APT repo

cat << EOF > /etc/apt/sources.list.d/openvz-rhel6.list
deb http://download.openvz.org/debian wheezy main
# deb http://download.openvz.org/debian wheezy-test main
EOF

# Import GPG key

wget http://ftp.openvz.org/debian/archive.key
apt-key add archive.key

# Update APT DB

apt-get update

# Install OpenVZ Kernel

apt-get -y install linux-image-openvz-amd64

# System configuration

sed -i 's/kernel.sysrq = 0/kernel.sysrq = 1/g' /etc/sysctl.conf
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
echo 'net.ipv6.conf.default.forwarding = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.proxy_arp = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.rp_filter = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.send_redirects = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.send_redirects = 0' >> /etc/sysctl.conf

# Install OpenVZ tools

apt-get -y install vzctl vzquota ploop vzstats

# Download templates

wget -P /vz/template/cache http://download.openvz.org/template/precreated/centos-6-x86.tar.gz
wget -P /vz/template/cache http://download.openvz.org/template/precreated/debian-7.0-x86.tar.gz
wget -P /vz/template/cache http://download.openvz.org/template/precreated/ubuntu-12.04-x86.tar.gz
wget -P /vz/template/cache http://download.openvz.org/template/precreated/ubuntu-13.10-x86.tar.gz

# Announcements

echo $'OpenVZ has now been setup and configured\n'
echo $'Four OpenVZ templates have been added to the system:\n'
echo $'centos-6-x86\ndebian-7.0-x86\nubuntu-12.04-x86\nubuntu-13.10-x86\n'

# Reboot System : Ah crap, unable to figure out key input, wait for it...

echo $'The system must go down for reboot now, you will be disconnected shortly'

reboot