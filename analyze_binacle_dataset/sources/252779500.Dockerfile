FROM debian:latest  
LABEL maintainer="gaetanlongree@gmail.com"  
  
ARG DEBIAN_FRONTEND=noninteractive  
  
ENV LDAP_CAPABLE 0  
ENV WORKGROUP WORKGROUP  
ENV LDAP_HOST 127.0.0.1  
ENV LDAP_SUFIX dc=contoso,dc=com  
ENV LDAP_USERS_SUFIX ou=Users,dc=contoso,dc=com  
ENV LDAP_GROUPS_SUFIX ou=Groups,dc=contoso,dc=com  
ENV LDAP_MACHINES_SUFIX ou=Computers,dc=contoso,dc=com  
ENV LDAP_ADMIN_DN cn=admin,dc=contoso,dc=com  
ENV LDAP_ADMIN_PASSWD P@$$w0rd  
ENV LDAP_SSL no  
ENV LDAP_TLS 0  
ENV LDAP_BASE_DN ou=Users,dc=contoso,dc=com  
  
ENV SMB_USER shareuser  
ENV SMB_USER_PASSWD password  
  
ENV SMB_EXT_USER extuser  
ENV SMB_EXT_USER_PASSWD extpassword  
  
RUN apt-get update && \  
apt-get install --no-install-recommends --no-install-suggests -y \  
samba libnss-ldap smbldap-tools ldap-utils wget perl make &&\  
cp -R /etc/samba /tmp/  
  
COPY entrypoint.sh /  
  
VOLUME /etc/samba  
VOLUME /etc/smbldap-tools  
VOLUME /var/lib/samba/private  
VOLUME /share  
  
EXPOSE 139  
EXPOSE 445  
ENTRYPOINT ["bash", "/entrypoint.sh"]  
  
CMD /usr/sbin/smbd -FSD < /dev/null  

