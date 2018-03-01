install
cdrom
lang en_US.UTF-8
keyboard us
network --onboot yes --bootproto dhcp --noipv6
services --disabled=NetworkManager --enabled=network 
rootpw kickstart
firewall --disabled
selinux --disabled
timezone --utc America/New_York
unsupported_hardware
bootloader --location=mbr
text
skipx
zerombr

clearpart --all --initlabel
authconfig --enableshadow --passalgo=sha512 --kickstart
#We want to make sure the disk size is slightly less than 
#what was defined in templates.json, otherwise you get errors
#on qemu install about not enough space
part / --size 4094 --fstype ext4 --label=/

firstboot --disabled
reboot
url --url http://p2-deploy1.ad.prodcc.net/yum/centos/7.3.1611/os/x86_64/

%packages --nobase --ignoremissing --excludedocs
@core
@compat-libraries
chrony
redhat-lsb-core
system-config-firewall
openssh-clients
openssh-server

# Packages to exclude
-logwatch
-java
%end

%pre
mkdir /mnt/floppy
mount /dev/fd0 /mnt/floppy
%end

%post --interpreter /bin/bash --log /root/ks-post.log
set -x
exec 2>&1

#Forcibly remove NetworkManager
yum -y remove NetworkManager

%include /mnt/floppy/yum_repos.kspart
%include /mnt/floppy/set_limits.kspart
%include /mnt/floppy/repos.ks
%include /mnt/floppy/securitypatch.kspart
%include /mnt/floppy/sanitize_network.kspart

#ugly hack to remove 'myhostname' from hosts entry of /etc/nsswitch.conf
#with 'myhostname' in place, we found that localhost returned ::1 instead of 127.0.0.1
cp -rp /etc/nsswitch.conf /etc/nsswitch.conf.dist
cat /etc/nsswitch.conf.dist | sed -re '/^hosts:/s/myhostname//' > /etc/nsswitch.conf

#for some reason "selinux --disabled" above, doesn't change the default setting in /etc/selinux/config like it used too
sed -rie 's/^SELINUX=.*$/SELINUX=disabled/' /etc/selinux/config


%end
