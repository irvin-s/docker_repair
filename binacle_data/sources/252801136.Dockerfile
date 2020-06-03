FROM phusion/baseimage:0.9.18  
MAINTAINER R0GGER  
  
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" TERM="xterm"  
ENV PATH /app/mistserver:$PATH  
ENV MISTSERVER=r.mistserver.org/dl/mistserver_64V2.6.tar.gz  
ENV DOMAIN=0.0.0.0  
CMD ["/sbin/my_init"]  
  
# add user/files  
RUN useradd -u 911 -U -d /config -s /bin/false mist  
RUN usermod -G users mist  
ADD start.sh /etc/my_init.d/start.sh  
ADD add_user_mist.sh /etc/my_init.d/add_user_mist.sh  
  
# install basics  
RUN apt-get update  
RUN apt-get install git wget -yq  
RUN chmod +x /etc/my_init.d/*.sh  
RUN mkdir -p /app/mistserver /config /media  
  
# install mistserver  
RUN wget -qO- ${MISTSERVER} | tar xvz -C /app/mistserver  
  
# clean up  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
VOLUME /config /media  
EXPOSE 4242 8080 1935 554  

