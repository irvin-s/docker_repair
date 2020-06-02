FROM centos:centos7  
  
RUN yum install -y epel-release && \  
yum update -y && \  
yum install -y nss_wrapper gettext && \  
yum clean all -y  
  
ENV USER_NAME=root NSS_WRAPPER_PASSWD=/tmp/passwd NSS_WRAPPER_GROUP=/tmp/group  
  
RUN touch ${NSS_WRAPPER_PASSWD} ${NSS_WRAPPER_GROUP} && \  
chgrp 0 ${NSS_WRAPPER_PASSWD} ${NSS_WRAPPER_GROUP} && \  
chmod g+rw ${NSS_WRAPPER_PASSWD} ${NSS_WRAPPER_GROUP}  
  
ADD passwd.template /passwd.template  
ADD nss_wrapper.sh /nss_wrapper.sh  
  
ENTRYPOINT ["/nss_wrapper.sh"]  

