FROM ubuntu:14.04  
MAINTAINER nick@7mbtech.com  
  
# update apt and install beanstalkd  
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \  
beanstalkd  
  
VOLUME ["/data"]  
EXPOSE 11300  
CMD ["/usr/bin/beanstalkd", "-f", "60000", "-b", "/data"]  

