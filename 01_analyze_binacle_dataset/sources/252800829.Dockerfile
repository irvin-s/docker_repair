FROM node:latest  
  
MAINTAINER David Bauer <db@dotcore.net>  
  
RUN yarn global add bower grunt-cli gulp-cli mocha nodemon --silent && \  
echo '{ "allow_root": true }' > /root/.bowerrc  
  
WORKDIR /workspace  

