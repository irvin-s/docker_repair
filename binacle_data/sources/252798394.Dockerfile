  
FROM ubuntu:16.04  
MAINTAINER vashchuk.denis@gmail.com  
RUN apt-get -yq update && apt-get -yq upgrade  
RUN apt-get install -yq rsync openssh-client ansible  

