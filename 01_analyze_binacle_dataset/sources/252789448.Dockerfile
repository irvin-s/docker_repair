FROM ubuntu:14.04  
MAINTAINER Dan Leehr <dan.leehr@duke.edu>  
  
RUN apt-get update && apt-get install -y \  
openjdk-7-jre-headless \  
trimmomatic="0.32+dfsg-1"  
  
CMD ["/usr/bin/java", "-jar", "/usr/share/java/trimmomatic.jar"]  

