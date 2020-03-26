FROM birchwoodlangham/ubuntu-jdk:latest  
  
MAINTAINER Tan Quach <tan.quach@birchwoodlangham.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN wget https://dl.bintray.com/sbt/debian/sbt-1.1.1.deb && \  
wget http://downloads.lightbend.com/scala/2.12.4/scala-2.12.4.deb && \  
dpkg -i sbt-1.1.1.deb && \  
dpkg -i scala-2.12.4.deb && \  
rm *.deb  

