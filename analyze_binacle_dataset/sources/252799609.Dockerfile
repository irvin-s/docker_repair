FROM ansible/centos7-ansible  
MAINTAINER Siddhartha Basu <siddhartha-basu@northwestern.edu>  
  
RUN useradd -m ansible \  
&& pip install apache-libcloud  
ENV LANG en_US.UTF-8  
ENV LC_ALL en_US.UTF-8  
WORKDIR /home/ansible  
ENV HOME /home/ansible  
USER ansible  
ENTRYPOINT ["/bin/bash", "-i", "-l"]  

