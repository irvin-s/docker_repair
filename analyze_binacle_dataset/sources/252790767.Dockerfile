# Base image cowsay:0.8  
FROM alpine:3.6  
MAINTAINER cash168  
RUN apk add --no-cache perl  
  
COPY cowsay /usr/bin/cowsay  
COPY default.cow /usr/share/cowsay/  
  
CMD ["/usr/bin/cowsay","Docker is good!"]  

