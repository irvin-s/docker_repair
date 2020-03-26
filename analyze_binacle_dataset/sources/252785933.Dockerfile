FROM ubuntu:xenial  
  
COPY ["setup.sh", "configure.sh", "/opt/bin/"]  
COPY ["sources.list", "/etc/apt/sources.list"]  
  
RUN /bin/bash /opt/bin/setup.sh  
RUN /bin/bash /opt/bin/configure.sh  
  
COPY ["bin/*", "/usr/local/bin/"]  
  
RUN chmod +x /usr/local/bin/*  

