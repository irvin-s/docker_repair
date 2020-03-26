FROM bravado/apache  
  
RUN pear install MDB2 MDB2#mysql  
  
ENV MYSQL_HOST "mysql"  
ENV DNS_HOSTMASTER hostmaster.domain.com  
ENV DNS_NS1 dns1.domain.com  
ENV DNS_NS2 dns2.domain.com  
  
ENV POWERADMIN_MYSQL_HOST $MYSQL_HOST  
ENV POWERADMIN_MYSQL_DATABASE "powerdns"  
ENV POWERADMIN_MYSQL_USER "poweradmin"  
ENV POWERADMIN_MYSQL_PASSWORD "password"  
ENV PUREFTPD_MYSQL_HOST $MYSQL_HOST  
ENV PUREFTPD_MYSQL_DATABASE "pureftpd"  
ENV PUREFTPD_MYSQL_USER "pureftpd"  
ENV PUREFTPD_MYSQL_PASSWORD "password"  
ENV OPENLDAP_DATABASE example.com  
# If empty, OPENLDAP_SUFFIX is automatically derived from OPENLDAP_DATABASE  
ENV OPENLDAP_SUFFIX ""  
# If empty, OPENLDAP_ROOT_PASSWORD is automatically generated on first run  
ENV OPENLDAP_ROOT_PASSWORD ""  
VOLUME [ "/var/lib/ldap" ]  
  
ADD /etc /etc  
  
ADD /html /var/www/html  
  
EXPOSE 389  

