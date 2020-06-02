FROM phusion/baseimage:0.9.17  
MAINTAINER rvschuilenburg  
# FORK FROM pducharme/plexconnect on GitHub  
# Set correct environment variables  
ENV HOME /root  
ENV DEBIAN_FRONTEND noninteractive  
ENV LC_ALL C.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US.UTF-8  
# Use baseimage-docker's init system  
CMD ["/sbin/my_init"]  
  
# Configure user nobody to match unRAID's settings  
RUN \  
usermod -u 99 nobody && \  
usermod -g 100 nobody && \  
usermod -d /home nobody && \  
chown -R nobody:users /home  
  
# Disable SSH  
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh  
  
# Refresh APT & Install Dependencies  
RUN apt-get update -q  
RUN apt-get install -qy python python-dev python-imaging wget unzip  
  
# Install PlexConnect (Master Branch)  
RUN wget https://github.com/iBaa/PlexConnect/archive/master.zip  
RUN unzip master.zip  
RUN mv PlexConnect-master/ /opt/plexconnect  
RUN chown nobody:users /opt/plexconnect  
  
EXPOSE 80 443  
# Add edge.sh to execute during container startup  
RUN mkdir -p /etc/my_init.d  
ADD edge.sh /etc/my_init.d/edge.sh  
RUN chmod +x /etc/my_init.d/edge.sh  
  
# Add PlexConnect to runit  
RUN mkdir /etc/service/plexconnect  
ADD plexconnect.sh /etc/service/plexconnect/run  
RUN chmod +x /etc/service/plexconnect/run  

