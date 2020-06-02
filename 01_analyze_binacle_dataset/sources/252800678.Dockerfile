#  
# doomkin/nodejs Dockerfile  
#  
# https://github.com/doomkin/nodejs  
#  
# Based on:  
# https://github.com/doomkin/ubuntu-ssh  
# https://github.com/dockerfile/nodejs  
#  
# Pull base image.  
FROM doomkin/ubuntu-ssh  
MAINTAINER Pavel Nikitin <p.doomkin@ya.ru>  
# Set the noninteractive frontend  
ENV DEBIAN_FRONTEND noninteractive  
  
# Build Node.JS  
RUN apt-get update && apt-get upgrade -y; \  
apt-get install -y python python-dev python-pip python-virtualenv; \  
cd /tmp; \  
wget http://nodejs.org/dist/node-latest.tar.gz; \  
tar xvzf node-latest.tar.gz; \  
rm -f node-latest.tar.gz; \  
cd node-v*; \  
./configure; \  
CXX="g++ -Wno-unused-local-typedefs" make; \  
CXX="g++ -Wno-unused-local-typedefs" make install; \  
cd /tmp; \  
rm -rf /tmp/node-v*; \  
npm install -g npm; \  
npm install -g forever; \  
echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc; \  
apt-get clean; \  
sed -i 's/^exit 0/service nginx start\nexit 0/' /etc/rc.local  
  
EXPOSE 22 80 443  
# Startup  
CMD /etc/rc.local; bash  

