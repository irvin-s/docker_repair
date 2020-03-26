FROM clarencep/lap53  
  
RUN yum install -y gcc make autoconf automake php-devel \  
&& yum clean all \  
&& find /var/log -type f -print0 | xargs -0 rm -rf /tmp/*  
  

