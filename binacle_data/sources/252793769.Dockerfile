FROM ubuntu:xenial  
  
LABEL maintainer="foersterfrank@gmx.de"  
LABEL description="Container to generate test data set for chloroExtractor"  
  
RUN apt update && apt install --yes pbzip2 wget bzip2  
  
ADD generate_dataset.sh /tmp  
  
VOLUME /data  
WORKDIR /tmp  
  
CMD /tmp/generate_dataset.sh  

