FROM agate/factual-docker-rvm-mri:2.3.1  
MAINTAINER agate<agate.hao@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y git python  
  
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -  
RUN apt-get install -y nodejs  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# deployer  
EXPOSE 3000  
# commander  
EXPOSE 3001  

