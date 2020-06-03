FROM ubuntu:precise  
MAINTAINER bobtfish@bobtfish.net  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update -qq -y && \  
apt-get install -qq -y hatop && \  
apt-get clean  
  
ENTRYPOINT ["/usr/bin/hatop"]  
CMD ["-s", "/socket/haproxy.sock"]  
  

