FROM ubuntu:14.04  
RUN apt-get update && \  
apt-get install -y nodejs npm imagemagick && \  
update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 && \  
npm install -y -g svg2png-cli  
  
WORKDIR /svg  
  
ENTRYPOINT ["svg2png"]

