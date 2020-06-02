FROM google/cadvisor  
MAINTAINER Christoph Auer <auer.chrisi@gmx.net>  
  
EXPOSE 80  
ENTRYPOINT ["/usr/bin/cadvisor", "-logtostderr", "--port=80"]  

