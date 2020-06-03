FROM java:8  
MAINTAINER Sean Chatman <xpointsh@gmail.com>  
  
# Download and Install GVM  
RUN curl http://api.gvmtool.net -o /tmp/gvm-install.sh  
RUN chmod 744 /tmp/gvm-install.sh  
RUN /tmp/gvm-install.sh  
  
ADD config /root/.gvm/etc/config

