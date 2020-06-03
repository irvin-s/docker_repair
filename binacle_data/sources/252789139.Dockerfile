FROM dsop/alpine-nodejs  
  
RUN apk --update add python make gcc musl-dev g++ git rsync && \  
rm -rf /var/cache/apk/*  
RUN npm install -g mocha && chmod +x /usr/bin/mocha  

