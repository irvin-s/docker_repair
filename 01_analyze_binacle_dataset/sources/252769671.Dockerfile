FROM maven:latest  
RUN apt-get update  
RUN apt-get install -y apt-utils unzip tar wget zip

