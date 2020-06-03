FROM ubuntu:16.04  
#RUN apt-get update && apt-get install -y curl  
#RUN curl -s https://install.zerotier.com/ | bash || true  
ADD zerotier.list /etc/apt/sources.list.d/zerotier.list  
ADD zt-gpg-key /zt-gpg-key  
RUN apt-key add /zt-gpg-key  
RUN apt-get update && apt-get install -y zerotier-one python python-requests  
  
ADD zerotier_allow.py /zerotier_allow.py  
  
ADD start.sh /start.sh  
  
CMD ["bash", "/start.sh"]  

