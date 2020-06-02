FROM frolvlad/alpine-oraclejdk8:slim  
MAINTAINER Roman Scherer <roman@burningswell.com>  
ADD ./target/burningswell-api.jar burningswell-api.jar  
CMD ["java", "-jar", "burningswell-api.jar"]  

