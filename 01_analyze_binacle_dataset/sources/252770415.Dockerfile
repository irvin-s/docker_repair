FROM askcs/ubuntu:16.04  
# Install Java.  
RUN \  
apt-get update && \  
apt-get install -y openjdk-8-jre && \  
rm -rf /var/lib/apt/lists/*  
# Define working directory.  
WORKDIR /data  
  
# Define commonly used JAVA_HOME variable  
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64  
# Define default command.  
CMD ["bash"]  

