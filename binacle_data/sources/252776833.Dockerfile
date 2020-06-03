FROM ubuntu:trusty  
MAINTAINER anders pearson <anders@columbia.edu>  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get -y install postfix  
ADD assets/run.sh /run.sh  
EXPOSE 25  
CMD /run.sh

