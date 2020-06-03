FROM bookatable/node-linux:latest  
MAINTAINER Bookatable - Mobile <mobile.devs@bookatable.com>  
  
ENV HOME=/home/strong-pm  
ENV WEB_SERVER_PORT=80  
ENV SLC_CTL_PORT=8701  
ENV SLC_CTL_SERVICE=example  
ENV ENVIRONMENT=local  
  
# copy the scripts to the container  
COPY ./scripts/ "$HOME/scripts/strongloop/"  
  
# Download and install Strongloop  
RUN \  
npm config set registry http://registry.npmjs.org/ && \  
npm install -g strongloop && \  
npm cache clear && \  
rm -rf /tmp/* /var/tmp/*  
  
WORKDIR $HOME

