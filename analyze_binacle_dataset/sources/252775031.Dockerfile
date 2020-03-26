FROM ubuntu:16.04  
COPY default/ /usr/local/picard/  
  
ENV JAVA_JAR_PATH "/usr/local/picard/"

