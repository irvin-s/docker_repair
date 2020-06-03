FROM ubuntu:14.04  
MAINTAINER s. rannou <mxs@sbrk.org>, Manfred Touron <m@42.am>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# deps  
RUN apt-get update && \  
apt-get upgrade -q -y && \  
apt-get install -q -y \  
git netcat golang bc build-essential  
  
# build  
RUN mkdir /usr/src/gorobot  
ADD . /usr/src/gorobot  
RUN cd /usr/src/gorobot && go build  
RUN cp /usr/src/gorobot/gorobot /usr/src/gorobot/root  
WORKDIR /usr/src/gorobot/root  
  
# admin port for commands  
EXPOSE 3112  
  
# here we go  
CMD ./gorobot -c root/gorobot.json  

