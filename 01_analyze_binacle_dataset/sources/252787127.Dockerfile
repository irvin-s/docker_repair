FROM bravissimolabs/baseimage  
MAINTAINER Luke Bennett <luke.bennett@bravissimo.com>  
  
# Add Git and Node package sources  
RUN add-apt-repository -y ppa:git-core/ppa; \  
curl -sL https://deb.nodesource.com/setup | sudo bash -  
  
# Install packages  
RUN apt-get install -yq \  
git \  
nodejs  
  
# Select specific version of Node.js via n  
RUN npm install -g n; \  
n 6.2.0;  
  
# Clean up  
RUN apt-get clean  
  
CMD ["bash"]  

