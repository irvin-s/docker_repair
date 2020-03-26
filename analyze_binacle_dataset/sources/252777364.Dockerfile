FROM cghome/dode-webdev  
  
MAINTAINER Chris.Gross <cgHome@gmx.net>  
  
RUN npm install -g gulp bower  
  
# Clearing Node’s NPM Cache  
RUN rm -rf ~/.npm &&\  
npm cache clear

