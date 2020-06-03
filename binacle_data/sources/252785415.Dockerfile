# Pull base image.  
FROM dockerfile/ubuntu  
  
# Install fontforge.  
RUN \  
add-apt-repository ppa:fontforge/fontforge -y && \  
apt-get update && \  
apt-get install -y fontforge-nox python-fontforge  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["bash"]  

