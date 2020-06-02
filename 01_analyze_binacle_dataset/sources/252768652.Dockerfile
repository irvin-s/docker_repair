FROM anastasiia911/debian-jdk-8:latest  
  
ENV NIFI_HOME = /home/nifi  
  
RUN mkdir -p ${NIFI_HOME} && \  
cd /home/nifi && \  
wget "http://mirrors.m247.ro/apache/nifi/1.1.2/nifi-1.1.2-bin.tar.gz" && \  
tar -xzf nifi-1.1.2-bin.tar.gz && \  
rm nifi-1.1.2-bin.tar.gz  
  
EXPOSE 8080 8081  
WORKDIR ${NIFI_HOME}  
  
CMD ./bin/nifi.sh run

