FROM ubuntu:14.04  
MAINTAINER Doug Moscrop (doug.moscrop@gmail.com)  
  
RUN apt-get update -y  
RUN apt-get install git -y  
  
VOLUME /src  
WORKDIR /src  
  
CMD echo $(git rev-parse --verify HEAD) > /src/.gitsha

