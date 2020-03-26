FROM shawnzhu/ruby  
  
RUN apt-get update  
  
# Install Python junk  
RUN apt-get install -y python-software-properties git curl socat wget  
  
# Install Node.js/ Yeoman / Bower / Grunt / generator-jekyllrb  
RUN \  
cd /tmp && \  
curl -O http://nodejs.org/dist/v0.10.38/node-v0.10.38.tar.gz && \  
tar xvzf node-v0.10.38.tar.gz && \  
rm -f node-v0.10.38.tar.gz && \  
cd node-v* && \  
./configure && \  
CXX="g++ -Wno-unused-local-typedefs" make && \  
CXX="g++ -Wno-unused-local-typedefs" make install && \  
cd /tmp && \  
rm -rf /tmp/node-v* && \  
npm install -g npm && \  
npm install -g bower && \  
npm install -g grunt-cli grunt && \  
npm install -g yo && \  
npm install -g generator-jekyllrb && \  
echo -e '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc  
  
#Clean apt-get junk  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Add a yeoman user because grunt doesn't like junk  
RUN adduser --disabled-password --gecos "" yeoman; \  
echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  
ENV HOME /home/yeoman  
USER yeoman  
WORKDIR /home/yeoman  
  
# Expose the port junk  
EXPOSE 9000  

