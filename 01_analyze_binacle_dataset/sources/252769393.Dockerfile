# AlpineLinux with OpenJDK 7 (if anything less than this let me know)  
FROM alpine:3.2  
MAINTAINER Mint Ekalak <mint.com@gmail.com>  
  
#OpenJDK 7 rocks!  
RUN apk --update add openjdk7-jre  
  
#Default command /bin/sh -c  
CMD ["/usr/bin/java", "-version"]

