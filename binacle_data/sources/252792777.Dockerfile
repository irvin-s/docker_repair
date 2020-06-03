FROM ubuntu:14.04  
RUN apt-get update &&\  
apt-get -y install software-properties-common &&\  
add-apt-repository -y ppa:securityonion/stable &&\  
apt-get remove -y software-properties-common rsyslog &&\  
apt-get -y autoremove &&\  
apt-get update &&\  
apt-get -y dist-upgrade &&\  
apt-get clean &&\  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
CMD ["/bin/bash"]  

