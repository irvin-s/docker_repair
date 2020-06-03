FROM alpine:3.4  
RUN apk --update add mercurial tcpdump openssh-client ca-certificates ethtool  
  
WORKDIR /opt  
  

