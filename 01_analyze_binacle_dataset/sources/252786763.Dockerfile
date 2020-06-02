FROM phusion/baseimage:0.9.11  
MAINTAINER needo <needo@superhero.org>  
ENV DEBIAN_FRONTEND noninteractive  
  
# Set correct environment variables  
ENV HOME /root  
  
# Use baseimage-docker's init system  
CMD ["/sbin/my_init"]  
  
# Fix a Debianism of the nobody's uid being 65534  
RUN usermod -u 99 nobody  
RUN usermod -g 100 nobody  
  
RUN apt-get update -q  
  
# Install Dependencies  
RUN apt-get install -qy python wget  
  
# Install headphones v0.3.4  
RUN mkdir /opt/headphones  
RUN wget -P /tmp/ https://github.com/rembo10/headphones/archive/v0.3.4.tar.gz  
RUN tar -C /opt/headphones -xvf /tmp/v0.3.4.tar.gz --strip-components 1  
RUN chown nobody:users /opt/headphones  
  
EXPOSE 8181  
# headphones Configuration  
VOLUME /config  
  
# Downloads directory  
VOLUME /downloads  
  
# Music directory  
VOLUME /music  
  
# Add edge.sh to execute during container startup  
RUN mkdir -p /etc/my_init.d  
ADD edge.sh /etc/my_init.d/edge.sh  
RUN chmod +x /etc/my_init.d/edge.sh  
  
# Add headphones to runit  
RUN mkdir /etc/service/headphones  
ADD headphones.sh /etc/service/headphones/run  
RUN chmod +x /etc/service/headphones/run  

