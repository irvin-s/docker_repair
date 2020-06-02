# Version: 0.0.1  
FROM akagelo/jenkins-slave-java8  
MAINTAINER Oleg Vyukov <gelo@vyukov.ru>  
  
  
  
# обновляшки  
RUN apt-get update  
  
#maven из репов debian  
RUN apt-get install -y maven openjdk-7-jdk  
  
#java 8 по умолчанию  
RUN update-java-alternatives -s java-1.8.0-openjdk-amd64  
  
RUN mkdir /home/jenkins/.m2 && chown jenkins:jenkins /home/jenkins/.m2  
  
VOLUME ["/home/jenkins/.m2"]

