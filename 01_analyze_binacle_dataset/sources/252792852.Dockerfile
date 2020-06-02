FROM debian:stable  
MAINTAINER Cheuk Wing leung "cwleung@kth.se"  
RUN apt-get update && apt-get install -y doxygen graphviz  
  
COPY start /usr/local/bin/start  
RUN chmod +x /usr/local/bin/start  
  
ENTRYPOINT ["/usr/local/bin/start"]  

