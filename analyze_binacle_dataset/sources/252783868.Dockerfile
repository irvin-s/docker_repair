FROM progrium/busybox  
MAINTAINER Kai Davenport <kaiyadavenport@gmail.com>  
  
ADD https://get.docker.io/builds/Linux/x86_64/docker-1.2.0 /bin/docker  
RUN chmod +x /bin/docker  
  
ADD http://stedolan.github.io/jq/download/linux64/jq /bin/jq  
RUN chmod +x /bin/jq  
  
ADD ./deps/base64 /bin/base64  
RUN chmod +x /bin/base64  
  
RUN opkg-install curl bash  
  
ADD ./arpanet /bin/arpanet  
  
ENV SHELL /bin/bash  
  
ENTRYPOINT ["/bin/arpanet"]  
CMD []

