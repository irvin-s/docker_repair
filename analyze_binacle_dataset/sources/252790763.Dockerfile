FROM linuxserver/baseimage  
MAINTAINER Casey Webb <notcaseywebb@gmail.com>  
  
RUN apt-get -q update && apt-get -qy install openjdk-7-jre  
RUN curl http://subsonic.org/download/subsonic-6.0.deb -o /tmp/subsonic.deb  
RUN dpkg -i /tmp/subsonic.deb  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# linuxserver.io base image magic  
COPY init/ /etc/my_init.d/  
COPY services/ /etc/service/  
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh  
  
COPY subsonic /etc/default/subsonic  
  
VOLUME ["/config", "/music", "/podcasts", "/playlists"]  
EXPOSE 4040  

