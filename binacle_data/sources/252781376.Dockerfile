FROM ubuntu  
  
MAINTAINER bander2.imda@gmail.com  
  
RUN apt-get update \  
&& apt-get install -y \  
ruby \  
ruby-dev \  
libgdbm-dev \  
nodejs \  
npm \  
git \  
build-essential \  
&& gem install jekyll bundler \  
&& npm install -g bower \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& ln -s `which nodejs` /usr/bin/node \  
&& echo '{ "allow_root": true }' > /root/.bowerrc  
  
CMD ["bash"]  

