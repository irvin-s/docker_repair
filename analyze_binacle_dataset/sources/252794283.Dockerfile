FROM ubuntu:16.04  
MAINTAINER Derrick Shultz <warlock05@gmail.com>  
RUN apt-get update && apt-get install -y --force-yes lame madplay ezstream  
VOLUME ["/ezstream", "/music"]  
ENTRYPOINT ["/usr/bin/ezstream", "-c", "/ezstream/ezstream.xml"]  

