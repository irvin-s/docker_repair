FROM ubuntu:trusty  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get -yq install \  
unixodbc libmyodbc xvfb cifs-utils libqtwebkit4 krb5-user \  
winbind ldap-utils libsasl2-modules-gssapi-mit \  
snmp \  
samba  
  
ADD Server-Linux-x86_64.sh /Server-Linux-x86_64.sh  
  
ADD run.sh /run.sh  
RUN chmod 755 /*.sh  
  
CMD ["/run.sh"]  

