FROM ubuntu:14.04  
MAINTAINER Grant Hutchinson <h.g.utchinson@gmail.com>  
  
ADD ./bin /worker/bin  
ADD ./lib /worker/lib  
ADD pubspec.yaml /worker/pubspec.yaml  
ADD CHANGELOG.md /worker/CHANGELOG.md  
ADD README.md /worker/README.md  
ADD LICENSE /worker/LICENSE  
  
RUN apt-get update && \  
apt-get install -y software-properties-common python-software-properties && \  
add-apt-repository -y ppa:hachre/dart && apt-get update && \  
apt-get install -y dartsdk dartium git && \  
cd /worker/ && pub get && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 12311  
WORKDIR /worker  
CMD ["/usr/bin/dart", "/worker/bin/main.dart", "-server", "-pass test"]  
  

