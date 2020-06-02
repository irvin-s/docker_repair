FROM beevelop/nodejs-python-ruby  
  
MAINTAINER Maik Hummel <m@ikhummel.com>  
  
ENV WADE_NPM_PACKS="grunt-cli bower gulp phantomjs protractor webpack"  
  
RUN apt-get update && \  
apt-get install -y git ssh libfreetype6 libfontconfig1 && \  
npm i --unsafe-perm -g $WADE_NPM_PACKS && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
apt-get autoremove -y && apt-get clean  

