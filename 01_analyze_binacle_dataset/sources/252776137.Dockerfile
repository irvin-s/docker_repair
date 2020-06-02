FROM alpine:3.7  
RUN apk add --no-cache bash openjdk8 openjdk8-jre nodejs nodejs-npm  
CMD ["/usr/bin/java", "-version"]  

