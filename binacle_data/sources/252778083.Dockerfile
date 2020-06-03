FROM appertise/oracle-jdk8  
MAINTAINER Appertise <appertise.co@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && \  
apt-get install -y software-properties-common wget unzip && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN wget http://www.baasbox.com/download/baasbox-stable.zip && \  
unzip -o baasbox-stable.zip && \  
mv baasbox*/ /opt/baasbox && \  
rm /opt/baasbox/start && \  
mkdir -p /var/data/baasbox  
  
EXPOSE 9000  
VOLUME /var/data/baasbox  
  
COPY start /opt/baasbox/  
  
ENTRYPOINT /opt/baasbox/start  

