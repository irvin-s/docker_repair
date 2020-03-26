FROM 99taxis/oracle-java8  
MAINTAINER "Fabio Hisamoto" <fabio@99taxis.com>  
  
RUN \  
apt-get update && \  
apt-get install -y \  
ruby \  
nodejs npm nodejs-legacy \  
build-essential \  
chrpath \  
libssl-dev libxft-dev libfreetype6 libfreetype6-dev \  
imagemagick libjpeg-progs jhead libapr1 libapr1-dev \  
libfontconfig1 libfontconfig1-dev && \  
rm -rf /var/lib/apt/lists/*  
  
RUN \  
gem install sass  
  
RUN \  
npm install -g uncss  

