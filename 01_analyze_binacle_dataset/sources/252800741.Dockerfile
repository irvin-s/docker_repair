FROM dorftv/ffmpeg-core  
MAINTAINER Stefan Hageneder <stefan.hageneder@dorftv.at>  
  
ADD install_codem_transcode.yml /root/  
ADD requirements.yml /root/  
  
WORKDIR /root  
RUN cd /root && \  
ansible-galaxy install -r requirements.yml --force && \  
ansible-playbook install_codem_transcode.yml && ldconfig && \  
rm -rf /tmp/* /var/tmp/* && apt-get clean && apt-get autoclean  
  
CMD ["-c /opt/codem-transcode/config.json"]  
ENTRYPOINT ["/opt/codem-transcode/bin/codem-transcode"]  
  

