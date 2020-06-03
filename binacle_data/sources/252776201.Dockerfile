FROM ubuntu:15.10  
MAINTAINER Bogdan Popa <bogdan@defn.io>  
  
RUN apt-get update  
RUN apt-get install -y build-essential libgmp-dev libssl-dev mlton  
  
ADD http://www.impredicative.com/ur/urweb-20151122.tgz /tmp/urweb-20151122.tgz  
RUN tar xzf /tmp/urweb-20151122.tgz  
RUN rm /tmp/urweb-20151122.tgz  
RUN mv urweb-20151122 /urweb  
  
WORKDIR /urweb  
RUN ./configure && make && make install  
  
RUN mkdir /app  
WORKDIR /app  
VOLUME /app  

