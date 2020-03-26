#  
# Pull base image  
#  
FROM ubuntu:14.04  
#  
# Install NSIS  
#  
RUN apt-get update && apt-get -y install nsis  
  
#  
# Set up the working directory  
#  
WORKDIR /build  
  
#  
# Add the build script  
#  
ADD build.sh .  
RUN chmod +x ./build.sh  
ENTRYPOINT ./build.sh  

