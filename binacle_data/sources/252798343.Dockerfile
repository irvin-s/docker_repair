FROM debian:testing  
#MAINTAINER jakub.blaszczyk@sap.com  
ONBUILD RUN apt-get update  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV TERM xterm  
  
# Install the cpp compiler  
RUN apt-get update && apt-get install -y gcc g++ build-essential manpages-dev  
  
# Create volumes for input and output  
VOLUME /input  
VOLUME /output  
# The entrypoint is the script that compiles the source files. fill it out  
ADD files/entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["example"]  

