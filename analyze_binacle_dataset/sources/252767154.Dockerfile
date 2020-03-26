FROM node:slim  
MAINTAINER Alex  
  
# Install git, sudo  
RUN apt-get -yq update && \  
apt-get -yq install git sudo && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
# Add a user  
RUN adduser --disabled-password --gecos '' user && \  
adduser user sudo && \  
echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  
# Set HOME  
ENV HOME /home/user  
# Install Yeoman with react generators  
RUN npm install -g yo \  
generator-react-fullstack \  
generator-react-webpack \  
generator-react-static && \  
rm -rf ~/.npm && npm cache clear  
  
# Install lib dependencies  
RUN apt-get -yq update && \  
apt-get -yq install bzip2 libfreetype6 libfontconfig && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
# Set app dir  
RUN mkdir /app && chown user:user /app  
WORKDIR /app  
  
# Run as user  
USER user  
# Expose the port  
EXPOSE 3000 3001  
# Open bash by default  
CMD /bin/bash  

