FROM alpine:3.7  
EXPOSE 2525  
CMD ["mb"]  
  
ENV NODE_VERSION=8.9.3-r1  
  
RUN apk update \  
&& apk add --no-cache nodejs=${NODE_VERSION}  
  
ENV MOUNTEBANK_VERSION=1.14.1  
RUN npm install -g mountebank@${MOUNTEBANK_VERSION} \--production \  
&& npm cache clean --force 2>/dev/null \  
&& rm -rf /tmp/npm*  

