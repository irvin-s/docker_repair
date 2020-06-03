FROM debian:jessie  
#MAINTAINER digmore  
  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \  
knot \  
&& rm -fr /var/lib/apt/lists/* \  
&& rm -fr /tmp/* \  
&& rm -fr /var/tmp/*  
  
RUN mkdir /etc/knot/zones  
COPY knot.conf /etc/knot/knot.conf  
RUN /usr/lib/knot/prepare-environment /etc/knot/knot.conf  
  
EXPOSE 53/udp 53/tcp  
  
ENTRYPOINT ["/usr/sbin/knotd","-c","/etc/knot/knot.conf"]  
  

