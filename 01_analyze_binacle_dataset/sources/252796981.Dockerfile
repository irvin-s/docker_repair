FROM debian:jessie  
  
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-i386/jre  
ENV JAVA_HOME_LIB $JAVA_HOME/lib  
  
# Installing 32 bits version of JDK for MCC lib  
RUN apt-get update  
RUN apt-get install -y build-essential  
RUN apt-get install -y libc6-dev  
RUN apt-get install -y libc6-dev-i386  
RUN apt-get install -y wget  
RUN apt-get clean  

