FROM dockette/jessie  
  
MAINTAINER Milan Sulc <sulcmil@gmail.com>  
  
RUN apt-get update && apt-get dist-upgrade -y && \  
# APP PART  
apt-get install -y perl libperl-critic-perl && \  
# CLEANING PART  
apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \  
rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*  
  
CMD ["perl"]  

