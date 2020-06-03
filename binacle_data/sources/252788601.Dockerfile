FROM openjdk:8-jre  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
apt-transport-https \  
nano  
  
COPY lsc-project.list /etc/apt/sources.list.d/  
COPY RPM-GPG-KEY-LTB-project /root/  
  
RUN apt-key add /root/RPM-GPG-KEY-LTB-project && \  
apt-get update && apt-get install -y \  
lsc  
  
COPY mysql-connector-java-5.1.44-bin.jar /usr/lib/lsc/  
  
ENV DEBIAN_FRONTEND teletype  
ENTRYPOINT [ "bash" ]  

