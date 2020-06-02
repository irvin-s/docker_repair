FROM node:latest  
MAINTAINER Arno0x0x - https://twitter.com/Arno0x0x  
  
ENV SOURCE_URL="https://github.com/xwiki-labs/cryptpad"  
# Install Cryptpad from the GitHub repo, master branch  
RUN git clone ${SOURCE_URL} \  
&& cd cryptpad \  
&& npm install \  
&& npm install -g bower \  
&& bower install --allow-root  
  
# Copies the config.js, with logging to stdout set to true  
COPY config.js /cryptpad/  
  
WORKDIR /cryptpad  
  
EXPOSE 3000  
ENTRYPOINT ["node"]  
CMD ["./server.js"]

