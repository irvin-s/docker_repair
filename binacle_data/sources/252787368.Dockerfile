FROM alpine:3.4  
RUN apk add \--update git bash openssh  
RUN adduser -S bot -s /bin/bash  
USER bot  
WORKDIR /home/bot  
ADD post-message /usr/bin/post-message  
ENTRYPOINT ["/usr/bin/post-message"]  
  

