from doumadou/centos7.1_base:latest  
  
ADD ./install.sh /tmp/install.sh  
  
RUN cd /tmp/ && chmod +x install.sh && ./install.sh && rm /tmp/* -rfv  

