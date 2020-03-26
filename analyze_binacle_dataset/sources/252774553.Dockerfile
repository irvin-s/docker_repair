FROM barkingiguana/base  
  
MAINTAINER Craig R Webster <craig@barkingiguana.com>  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq openjdk-7-jre-headless  
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64  
ENV PATH $PATH:$JAVA_HOME/bin  

