FROM node:9.11.1-alpine  
  
ENV FORMIO_VERSION 1.28.0  
  
RUN apk update \  
&& apk add bash git openssh openssl \  
&& wget "https://github.com/formio/formio/archive/v$FORMIO_VERSION.tar.gz" \  
&& tar -zxvf v$FORMIO_VERSION.tar.gz \  
&& mv formio-$FORMIO_VERSION formio \  
&& cd formio \  
&& apk --no-cache add --virtual native-deps \  
g++ gcc libgcc libstdc++ linux-headers make python \  
&& npm install --quiet node-gyp -g \  
&& npm install --quiet \  
&& apk del native-deps  

