#  
# OpenJDK Java 8 Dockerfile  
#  
# Pull base image.  
FROM debian:8  
# Install Java.  
RUN \  
echo "deb http://httpredir.debian.org/debian jessie-backports main" \  
> /etc/apt/sources.list.d/backports.list \  
&& apt-get update \  
&& apt-get install -y openjdk-8-jre  
  
# Define working directory.  
WORKDIR /data  
  
# Define commonly used JAVA_HOME variable  
# ENV JAVA_HOME /usr/lib/jvm/java-8-oracle  
# Define default command.  
CMD ["bash"]  

