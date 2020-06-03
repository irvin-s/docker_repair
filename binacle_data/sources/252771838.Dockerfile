FROM alpine:latest  
  
RUN apk add --update nodejs  
RUN npm install -g npm  
  
# Create and login as hubot user (will not run as root)  
RUN adduser hubot -h /hubot -s /bin/sh -D  
USER hubot  
WORKDIR /hubot  
  
# Copy Hubot sources to images  
COPY hubot /hubot  
  
# And go  
ENTRYPOINT ["/bin/sh", "-c", "cd ~; ./bin/hubot -a slack;"]  

