FROM ubuntu:16.04  
MAINTAINER Cédric Dué "cedric.due@gmail.com"  
# install Node & Git  
RUN apt-get update && apt-get install -y \  
git \  
git-core \  
nodejs \  
npm \  
libfontconfig \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Create a symlink for nodejs  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
# installing angular-cli as a global dependency  
RUN npm install -g angular-cli && npm cache clean && rm -rf ~/.npm  
  
WORKDIR /app  
  
EXPOSE 4200  
EXPOSE 49153  
#  
# start a bash terminal  
#  
ENTRYPOINT ["/bin/bash"]  

