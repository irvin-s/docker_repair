FROM factual/docker-base  
  
MAINTAINER agate<agate.hao@gmail.com>  
  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y curl  
RUN apt-get install -y build-essential  
  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -  
RUN apt-get install -y nodejs  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 3000  
ADD bootstrap.sh /etc/my_init.d/099_bootstrap  

