FROM centos:7  
RUN yum install -y \  
openldap \  
openldap-clients \  
openldap-servers \  
&& yum clean all  
  
COPY ./samba.schema /etc/openldap/schema/samba.schema  
COPY ./schema.conf /schema.conf  
COPY ./setup.ldif /setup.ldif  
COPY ./DB_CONFIG /var/lib/ldap/DB_CONFIG  
  
RUN slaptest -f /schema.conf -F /etc/openldap/slapd.d \  
&& chown -R ldap:ldap /etc/openldap/slapd.d \  
&& chown -R ldap:ldap /var/lib/ldap \  
&& slapd -u ldap -h ldapi:/// \  
&& sleep 10 \  
&& ldapmodify -H ldapi:/// -f /setup.ldif \  
&& rm -f /schema.conf /setup.ldif  
  
CMD ["slapd", "-d", "32768", "-u", "ldap", "-h", "ldapi:/// ldap:///"]  
  
EXPOSE 389 636  
VOLUME ["/var/lib/ldap", "/etc/openldap"]  

