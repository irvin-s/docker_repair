FROM ubuntu:16.04  
MAINTAINER Adrien Leravat <Pixep@users.noreply.github.com>  
  
# Install prerequisites  
RUN echo nameserver 8.8.8.8 > /etc/resolv.conf  
RUN apt-get update && apt-get -y install git maven default-jdk  
  
RUN mkdir -p /root/src/  
  
# Get Californium  
WORKDIR /root/src  
RUN git clone https://github.com/eclipse/californium.git  
WORKDIR /root/src/californium  
RUN git checkout tags/1.0.6  
  
# Building is not necessary: Binaries are in the repository.  
# Skip tests to avoid failure in Docker automated build environment.  
RUN mvn clean install -q -DskipTests  
  
WORKDIR /root  
ADD scripts /root/scripts  
RUN chmod +x /root/scripts/*  
  
EXPOSE 5683/udp  
  
CMD ["/root/scripts/start-plugtest-server.sh"]  

