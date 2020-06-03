FROM avoronkin/nvm  
  
ENV NODE_VERSION "v0.11.16"  
# Install node.js  
RUN /bin/bash -c ". /.nvm/nvm.sh && \  
nvm install $NODE_VERSION && \  
nvm use $NODE_VERSION && \  
nvm alias default $NODE_VERSION && \  
ln -s /.nvm/$NODE_VERSION/bin/node /usr/bin/node && \  
ln -s /.nvm/$NODE_VERSION/bin/npm /usr/bin/npm"  

