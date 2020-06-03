FROM centos:7  
MAINTAINER Søren Roug <soren.roug@eea.europa.eu>  
  
# Can be mapped for a primary server  
#VOLUME /var/lib/ldap  
  
RUN yum install -y openldap-servers openldap openldap-clients wget \  
&& mkdir -p /var/lib/ldap \  
&& chown ldap.ldap /var/lib/ldap \  
&& chmod 700 /var/lib/ldap  
  
COPY entrypoint.sh /  
COPY eionet.schema /etc/openldap/schema/  
COPY DB_CONFIG /etc/openldap/  
  
RUN mkdir /etc/cron.eea/  
ADD backup_eionet_ldap /etc/cron.eea/  
  
EXPOSE 389 636  
  
CMD /entrypoint.sh  

