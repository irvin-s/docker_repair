FROM alpine:edge  
  
MAINTAINER Demoiselle Framework <demoiselle.framework@gmail.com>  
  
RUN apk update && \  
apk add ca-certificates openssh openjdk8 git maven curl && \  
rm -rf /var/cache/apk/*  
  
# Set the working directory to jboss' user home directory  
WORKDIR /opt/  
  
# User root user to install software  
USER root  
  
# Set the JAVA_HOME variable to make it clear where Java is located  
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk  
ENV PATH=$PATH:~/bin  
  
# Expose the ports we're interested in  
EXPOSE 8080  

