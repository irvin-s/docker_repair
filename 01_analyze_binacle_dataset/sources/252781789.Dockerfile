FROM ubuntu:trusty  
MAINTAINER Chris Jean <chris@chrisjean.com>  
  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y git coffeescript nodejs php5-cli  
  
ADD ./build-zxcvbn-data /usr/local/bin/  
RUN chmod +x /usr/local/bin/build-zxcvbn-data  
  
RUN mkdir /var/zxcvbn-data  
  
VOLUME /var/zxcvbn-data  
  
CMD ["/usr/local/bin/build-zxcvbn-data"]  

