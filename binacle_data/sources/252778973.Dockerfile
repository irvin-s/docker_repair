FROM frolvlad/alpine-oraclejdk8:slim  
MAINTAINER Roman Scherer <roman@burningswell.com>  
ADD ./bin/bs-graphql /usr/local/bin/bs-graphql  
ADD ./target/burningswell-graphql.jar /usr/share/java/burningswell-graphql.jar  
CMD ["bs-graphql"]  

