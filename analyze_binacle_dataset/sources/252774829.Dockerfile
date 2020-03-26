#  
# Node.js Dockerfile  
#  
# https://github.com/dockerfile/nodejs  
#  
# Pull base image.  
FROM dockerfile/python  
  
# Install Node.js  
RUN \  
cd /tmp && \  
wget http://nodejs.org/dist/v0.10.28/node-v0.10.28.tar.gz && \  
tar xvzf node-v0.10.28.tar.gz && \  
rm -f node-v0.10.28.tar.gz && \  
cd node-v* && \  
./configure && \  
CXX="g++ -Wno-unused-local-typedefs" make && \  
CXX="g++ -Wno-unused-local-typedefs" make install && \  
cd /tmp && \  
rm -rf /tmp/node-v* && \  
npm install -g npm && \  
echo -e '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["bash"]  

