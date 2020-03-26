FROM debian:latest  
MAINTAINER Bruno Adelé "bruno@adele.im"  
  
USER root  
ENV DEBIAN_FRONTEND noninteractive  
  
# Java version  
ENV JDK_VERSION 7  
  
# Install Java  
RUN apt-get update  
RUN apt-get install -y openjdk-$JDK_VERSION-jdk  
  
# Set java environment  
ENV JAVA_HOME /usr/lib/jvm/java-$JDK_VERSION-openjdk-amd64  
ENV PATH $PATH:$JAVA_HOME/bin  
  
CMD ["java", "-version"]  

