FROM chandanibm/cordova  
  
MAINTAINER chandan <chanbora@in.ibm.com>  
  
ENV IONIC_VERSION 2.2.1  
RUN npm install -g nodemailer-cli  
  
RUN npm i -g grunt-cli && npm i -g gulp && npm i -g bower  
  
RUN npm i -g --unsafe-perm ionic@${IONIC_VERSION}

