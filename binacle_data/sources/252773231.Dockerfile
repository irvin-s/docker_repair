FROM ubuntu:vivid  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get -q update \  
&& apt-get install --yes -q \  
phantomjs \  
nodejs \  
nodejs-legacy \  
npm \  
git \  
mercurial \  
&& apt-get clean  

