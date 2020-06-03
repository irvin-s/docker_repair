# drunner_utils, a container to help dRunner do its thing.  
FROM debian  
MAINTAINER j842  
  
RUN apt-get update && \  
apt-get install -y p7zip-full gnupg wget curl openssl nano git && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# add in the assets.  
COPY ["./usrlocalbin","/usr/local/bin/"]  
RUN chown root:root /usr/local/bin/* && chmod -R 0555 /usr/local/bin/*  

