FROM phusion/baseimage:0.9.18  
# Set the timezone.  
RUN sudo echo "America/New_York" > /etc/timezone  
RUN sudo dpkg-reconfigure -f noninteractive tzdata  
  
# Set phusion/baseimage's correct settings.  
ENV HOME /root  
  
# Disable phusion/baseimage's ssh server.  
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh  

