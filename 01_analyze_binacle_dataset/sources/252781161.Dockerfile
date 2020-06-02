from ubuntu:13.10  
MAINTAINER Johnny Bergström <docker@joonix.se>  
  
# Stop complaining about trying to show a dialog for configuration input  
ENV DEBIAN_FRONTEND noninteractive  
  
# Helper for adding ppa's  
RUN apt-get install -y python-software-properties software-properties-common  
  
# Official i2p ppa  
RUN add-apt-repository ppa:i2p-maintainers/i2p  
RUN apt-get update && apt-get install -y i2p  
  
# Add configuration that will let non-localhost connect to the web interface  
ADD config /root/.i2p  
  
CMD ["/usr/bin/i2prouter", "launchdinternal"]  
  
# Web interface  
EXPOSE 7657  
# HTTP proxy  
EXPOSE 4444  
# For incoming connections  
EXPOSE 13768  

