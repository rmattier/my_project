cat << EOF > /etc/yum.repos.d/centos-7.3.1611.repo
[base]
name=CentOS-\$releasever - Base
baseurl=http://updatehost.ad.prodcc.net/yum/centos/7.3.1611/os/x86_64/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF

cat << EOF > /etc/yum.repos.d/updates-7.3.1611-20170302.repo
[updates]
name=CentOS-\$releasever - Updates
baseurl=http://updatehost.ad.prodcc.net/yum/centos/7.3.1611/updates-20170302/\$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF
