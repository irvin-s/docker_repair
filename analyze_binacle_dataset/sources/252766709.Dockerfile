FROM debian:jessie  
  
MAINTAINER Markus Ackermann <ackermann@informatik.uni-leipzig.de>  
  
# Let the conatiner know that there is no tty  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get upgrade -y  
  
RUN apt-get install -y jetty8 unzip python3 python3-rdflib  
  
RUN mkdir /pubby-prep  
  
ADD pubby-0.3.3.zip make-pubby-conf.py config.ttl.template /pubby-prep/  
ADD run.sh /  
  
CMD ["/run.sh"]  

