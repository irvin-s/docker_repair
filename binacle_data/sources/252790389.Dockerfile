FROM phusion/baseimage:0.9.18  
MAINTAINER needo <needo@superhero.org>  
ENV DEBIAN_FRONTEND noninteractive  
  
# Set correct environment variables  
ENV HOME /root  
  
# Use baseimage-docker's init system  
CMD ["/sbin/my_init"]  
  
# Fix a Debianism of the nobody's uid being 65534  
RUN usermod -u 99 nobody  
RUN usermod -g 100 nobody  
  
RUN add-apt-repository ppa:deluge-team/ppa  
ADD sources.list /etc/apt/  
RUN apt-get update -qq  
RUN apt-get install -qy deluged deluge-web unrar unzip p7zip  
  
#Path to a directory that only contains the deluge.conf  
VOLUME /config  
VOLUME /downloads  
  
EXPOSE 8112  
EXPOSE 58846  
# Add deluged to runit  
RUN mkdir /etc/service/deluged  
ADD deluged.sh /etc/service/deluged/run  
RUN chmod +x /etc/service/deluged/run  
  
# Add deluge-web to runit  
RUN mkdir /etc/service/deluge-web  
ADD deluge-web.sh /etc/service/deluge-web/run  
RUN chmod +x /etc/service/deluge-web/run  

