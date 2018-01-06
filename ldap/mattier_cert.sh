yum install -y openldap-clients nss-pam-ldapd
openssl req -new -x509 -nodes -out /etc/openldap/certs/mattiercert.pem -keyout /etc/openldap/certs/mattierkey.pem -days 3650
chown -R ldap:ldap /etc/openldap/certs/*.pem

