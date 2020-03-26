FROM mhart/alpine-node:4  
MAINTAINER Chris.Gross <cgHome@gmx.net>  
  
ENV HOME=/home  
WORKDIR $HOME/  
  
# Install Global NPM Modules  
RUN npm install -g concurrently lite-server  
  
# Clearing Node’s NPM Cache  
RUN rm -rf ~/.npm &&\  
npm cache clear  
  
VOLUME ${HOME}  
EXPOSE 8080  
CMD npm start

