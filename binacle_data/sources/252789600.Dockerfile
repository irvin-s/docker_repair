FROM dustin/tiny  
MAINTAINER Dustin Sallings "dustin@spy.net"  
ADD seriesly.tar.gz /  
  
RUN /sbin/ldconfig  
  
RUN apt-get update  
RUN apt-get install -y libv8-3.14.5 libicu52 libsnappy1  
  
EXPOSE 3133  

