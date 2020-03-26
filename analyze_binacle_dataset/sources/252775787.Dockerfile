# the RHEL/CentOS 7 version OpenLDAP  
FROM centos:7  
MAINTAINER Hong Xu <hong@topbug.net>  
  
RUN yum install -y openldap-servers openldap-clients  
  
env SLAPD_URL ldapi:/// ldap:///  
  
ADD run.sh /usr/bin/run.sh  
  
EXPOSE 389  
CMD ["/usr/bin/run.sh"]  

