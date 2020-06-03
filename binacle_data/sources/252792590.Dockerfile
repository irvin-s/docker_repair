# VERSION: 0.0.2  
FROM danielbeck/cordova-base:latest  
MAINTAINER Daniel Beck "d.danielbeck@googlemail.com"  
# Environment variables  
RUN apt-get update  
RUN rm -rf /var/lib/apt/lists/*  
RUN apt-get autoremove -y  
RUN apt-get clean  
  
#Download libraries  
RUN cd /tmp && cordova create fakeapp && \  
cd /tmp/fakeapp && \  
cordova platform add firefoxos && \  
cordova build && \  
cd ~/ && \  
rm -rf /tmp/fakeapp  
  
VOLUME ["/data"]  
WORKDIR /data  
ENTRYPOINT ["/usr/local/bin/cordova"]  
CMD ["-h"]  

