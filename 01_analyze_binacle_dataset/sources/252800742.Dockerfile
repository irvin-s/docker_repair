FROM hatsch/docker-ansible  
MAINTAINER Stefan Hageneder <hatsch@gmail.com>  
  
ADD build-ffmpeg.yml /root/  
ADD requirements.yml /root/  
  
RUN cd /root && \  
ansible-galaxy install -r requirements.yml --force && \  
ansible-playbook build-ffmpeg.yml && ldconfig && \  
rm -rf /tmp/* /var/tmp/* && apt-get clean && apt-get autoclean  

