FROM bananabb/ubuntu-base:base.2.0.0  
MAINTAINER BananaBb  
  
# Install Node.js  
RUN sudo apt-get update \  
&& sudo apt-get upgrade -y \  
&& sudo apt-get install -y \  
nodejs \  
npm \  
build-essential \  
libssl-dev  
  
# Setup file  
COPY install.sh install.sh  
COPY go1.9.1.linux-amd64.tar.gz go1.9.1.linux-amd64.tar.gz  
  
# Install Go & Setup `Node.js 6.0.0` by `NVM`(node.js version manager)  
ENV NVM_DIR $HOME/.nvm  
RUN bash ./install.sh \  
&& [ -s "$NVM_DIR/nvm.sh" ] && \\. "$NVM_DIR/nvm.sh" \  
&& [ -s "$NVM_DIR/bash_completion" ] && \\. "$NVM_DIR/bash_completion" \  
&& nvm install 6.0.0 \  
&& nvm alias default 6.0.0 \  
&& nvm use default \  
&& npm install pm2 -g \  
&& tar -xvf go1.9.1.linux-amd64.tar.gz \  
&& mv go /usr/local \  
&& rm install.sh \  
&& rm go1.9.1.linux-amd64.tar.gz  
  
# Create working DirectoryRUN /bin/bash -c "  
RUN mkdir -p /var/www/public  
WORKDIR /var/www/public  
ENV PATH $PATH:/usr/local/go/bin  
  
EXPOSE 80 443  
  
CMD ["/bin/bash"]

