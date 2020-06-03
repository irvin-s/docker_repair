FROM clarencep/lap56  
  
RUN yum install -y gcc make autoconf automake gd php56w-devel \  
&& yum clean all \  
&& find /var/log -type f -print0 | xargs -0 rm -rf /tmp/*  

