#  
# Installs serf on a busybox  
#  
FROM busybox  
  
MAINTAINER Colin Rhodes <colin@colin-rhodes.com>  
  
# download and install serf  
ADD https://dl.bintray.com/mitchellh/serf/0.6.0_linux_amd64.zip serf.zip  
RUN unzip serf.zip  
RUN rm serf.zip  
RUN mv serf /usr/bin  
  
VOLUME ["/etc/serf"]  
  
EXPOSE 7946 7373  
ENTRYPOINT ["/usr/bin/serf", "agent"]

