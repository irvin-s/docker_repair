# Pull base image.  
FROM advice/ubuntu  
  
ENV TERM xterm  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install Python.  
RUN \  
apt-get update && \  
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - && \  
apt-get install -y php5-cli php5-curl python nodejs && \  
rm -rf /var/lib/apt/lists/* && \  
mkdir -p /app  
  
# Define working directory.  
WORKDIR /app  
  
# Define default command.  
CMD ["bash"]  

