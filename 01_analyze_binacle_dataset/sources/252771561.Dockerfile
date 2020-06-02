FROM ubuntu:14.04  
MAINTAINER astartsky@gmail.com  
ENV DEBIAN_FRONTEND=noninteractive \  
REFRESHED_AT=2015_09_03  
  
# install packages  
RUN apt-get update && apt-get install -y \  
memcached  
  
# cleanup  
RUN apt-get clean && rm -rf /var/lib/apt/lists/*  
  
EXPOSE 11211  
ENTRYPOINT ["memcached"]  
CMD ["-u", "root", "-m", "64"]  

