FROM openjdk:8-jre  
RUN apt-get update && apt-get install -y python && apt-get clean  

