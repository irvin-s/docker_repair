# https://help.ubuntu.com/lts/serverguide/openldap-server.html
FROM ubuntu
WORKDIR /root
RUN apt-get update
RUN apt-get --yes --force-yes install expect
ADD ./ldap/install.e /root/
RUN expect /root/install.e
ADD ./ldap/add_content.ldif /root
RUN /etc/init.d/slapd start && ldapadd -x -D cn=admin,dc=nodomain -w password -f /root/add_content.ldif
RUN apt-get --yes --force-yes install gnutls-bin ssl-cert
RUN sh -c "certtool --generate-privkey > /etc/ssl/private/cakey.pem"
ADD ./ldap/ca.info /etc/ssl/
RUN certtool --generate-self-signed --load-privkey /etc/ssl/private/cakey.pem \
--template /etc/ssl/ca.info --outfile /etc/ssl/certs/cacert.pem
RUN certtool --generate-privkey --bits 1024 --outfile /etc/ssl/private/ldap01_slapd_key.pem
ADD ./ldap/ldap01.info /etc/ssl/
RUN certtool --generate-certificate \
--load-privkey /etc/ssl/private/ldap01_slapd_key.pem \
--load-ca-certificate /etc/ssl/certs/cacert.pem \
--load-ca-privkey /etc/ssl/private/cakey.pem \
--template /etc/ssl/ldap01.info \
--outfile /etc/ssl/certs/ldap01_slapd_cert.pem
RUN chgrp openldap /etc/ssl/private/ldap01_slapd_key.pem
RUN chmod 0640 /etc/ssl/private/ldap01_slapd_key.pem
RUN gpasswd -a openldap ssl-cert
ADD ./ldap/certinfo.ldif /root/
RUN /etc/init.d/slapd start && ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif
EXPOSE 389
CMD /etc/init.d/slapd start && tail -f /dev/null
