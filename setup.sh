#!/bin/bash

# Check if being run as root

if [ $USER != 'root' ]; then
echo "Sorry, you need to run this script as root."
exit
fi

# Install OpenVZ repo

wget -P /etc/yum.repos.d/ http://ftp.openvz.org/openvz.repo
rpm --import http://ftp.openvz.org/RPM-GPG-Key-OpenVZ

# Install OpenVZ Kernel

yum -y install vzkernel

# Disable SELinux

echo "SELINUX=disabled" > /etc/sysconfig/selinux

# Install VZ Tools

yum -y install vzctl
yum -y install vzquota
yum -y install ploop

# Download templates

wget -P /vz/template/cache http://download.openvz.org/template/precreated/centos-6-x86.tar.gz
wget -P /vz/template/cache http://download.openvz.org/template/precreated/debian-7.0-x86.tar.gz
wget -P /vz/template/cache http://download.openvz.org/template/precreated/ubuntu-12.04-x86.tar.gz
wget -P /vz/template/cache http://download.openvz.org/template/precreated/ubuntu-13.10-x86.tar.gz

# Disable iptables

/etc/init.d/iptables stop
chkconfig iptables off

# System configuration

sed -i 's/kernel.sysrq = 0/kernel.sysrq = 1/g' /etc/sysctl.conf
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
echo 'net.ipv6.conf.default.forwarding = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.proxy_arp = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.rp_filter = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.send_redirects = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.send_redirects = 0' >> /etc/sysctl.conf

# Announcements

echo $'OpenVZ has now been setup and configured\n'
echo $'Four OpenVZ templates have been added to the system:\n'
echo $'centos-6-x86\ndebian-7.0-x86\nubuntu-12.04-x86\nubuntu-13.10-x86\n'

# Reboot System

echo $'The system must go down for reboot now. Press Y to reboot or N to end the execution of this script :'
	read key
	until [ "${key}" = "Y" ] || [ "${key}" = "N" ]; do
		echo $'\n Please enter a valid option :'
		read key
	if [ "${key}" = "Y" ]; then
reboot
		elif [ "${key}" = "N" ]; then
			exit 0
      fi