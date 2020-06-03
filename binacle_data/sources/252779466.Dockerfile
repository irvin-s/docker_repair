FROM ubuntu:16.04  
RUN apt update  
  
RUN apt-get install -y bzip2  
RUN apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -  
RUN apt-get install -y nodejs  
RUN apt-get install -y ruby  
  
RUN apt-get install -y openjdk-8-jdk  
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64  
  
RUN apt-get install -y git  
  
RUN apt-get install -y maven  
RUN apt-get install -y ivy  
  
RUN useradd --create-home --shell /bin/sh hybris

