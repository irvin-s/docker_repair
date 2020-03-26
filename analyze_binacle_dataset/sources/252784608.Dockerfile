FROM ubuntu:latest  
MAINTAINER Klaudia Dziwon (dziwonklaudia@gmail.com)  
  
RUN apt-get update  
RUN apt-get install -y wget  
RUN apt-get install unzip  
  
# install java  
RUN apt-get install -y openjdk-8-jdk  
RUN apt-get install -y ant  
RUN apt-get clean  
  
# download & install scala  
RUN wget www.scala-lang.org/files/archive/scala-2.11.8.deb  
RUN dpkg -i scala-2.11.8.deb  
RUN apt-get update  
RUN apt-get install scala  
  
# download play framework & slick  
RUN wget https://www.lightbend.com/activator/template/bundle/play-slick  
  
# install mysql client  
RUN apt-get install mysql-client  
  
# install mysql client  
RUN apt-get install mysql-server  
  
RUN apt-get update  
  

