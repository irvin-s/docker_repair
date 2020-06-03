FROM node:6-alpine  
MAINTAINER furiousgeorge <furiousgeorgecode@gmail.com>  
MAINTAINER Danny Arnold <despair.blue@gmail.com>  
  
RUN apk --update add g++ make python python-dev git \  
&& git clone http://github.com/matterwiki/matterwiki /matterwiki \  
&& cd /matterwiki \  
&& git checkout v0.2.3 \  
&& npm install \  
&& npm run build \  
&& rm -rf .git \  
&& apk del --purge git g++ make \  
&& rm -rf /var/cache/apk/*  
  
EXPOSE 5000  
WORKDIR /matterwiki  
CMD ["npm", "start"]  

