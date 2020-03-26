FROM java:7u79  
MAINTAINER Akihiro Suda  
  
RUN apt-get update && \  
apt-get install --no-install-recommends -y \  
build-essential  
  
ADD sendfile-test.c /  
RUN gcc -o /sendfile-test /sendfile-test.c  
  
ADD test.sh /  
RUN chmod +x /test.sh  
  
CMD /test.sh  

