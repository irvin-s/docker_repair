FROM node:9.11.1-alpine  
  
LABEL maintainer="Burak Ince <burak.ince@linux.org.tr>"  
  
RUN apk update \  
&& apk add --no-cache git make gcc g++ python \  
&& npm config set loglevel error \  
&& npm install dredd@5.1.8 \  
&& apk del git make gcc g++ python \  
&& rm -rf /var/cache/apk/*  
  
ENV PATH ${PATH}:/node_modules/.bin  
  
ENTRYPOINT ["dredd","--version"]  

