FROM crazycode/python2  
MAINTAINER crazycode  
  
# Install Node.js  
RUN \  
cd /tmp && \  
wget http://nodejs.org/dist/node-latest.tar.gz && \  
tar xvzf node-latest.tar.gz && \  
rm -f node-latest.tar.gz && \  
cd node-v* && \  
./configure && \  
CXX="g++ -Wno-unused-local-typedefs" make && \  
CXX="g++ -Wno-unused-local-typedefs" make install && \  
cd /tmp && \  
rm -rf /tmp/node-v* && \  
npm install -g npm && \  
echo 'export PATH="node_modules/.bin:$PATH"' >> /root/.bashrc  
  
# Define working directory.  
WORKDIR /srv  
  
# Define default command.  
CMD ["bash"]

