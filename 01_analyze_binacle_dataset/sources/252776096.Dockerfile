FROM debian:wheezy  
  
RUN apt-get update && apt-get upgrade && apt-get install -y minidlna  
ADD ./run.sh /run.sh  
  
ENTRYPOINT ["/run.sh"]  

