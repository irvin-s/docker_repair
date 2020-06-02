FROM centos:7  
RUN yum install -y epel-release \  
&& yum install -y \  
nss-pam-ldapd \  
supervisor \  
&& yum clean all  
  
RUN mkdir --parents /etc/netgroup  
  
COPY ./system-auth /etc/pam.d/system-auth  
COPY ./nsswitch.conf /etc/nsswitch.conf  
COPY ./nslcd.conf /etc/nslcd.conf  
COPY ./supervisord.conf /etc/supervisord.conf  
  
CMD ["supervisord", "--configuration", "/etc/supervisord.conf"]  

