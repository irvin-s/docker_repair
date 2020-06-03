FROM ubuntu:14.04  
MAINTAINER Olivier Garcia "olivier@catchy.io"  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US.UTF-8  
ENV LC_ALL en_US.UTF-8  
ENV DEBIAN_FRONTEND noninteractive  
  
ADD build.sh /tmp/build.sh  
RUN sh /tmp/build.sh  
ADD run.sh /opt/run.sh  
EXPOSE 9292  
CMD ["/opt/run.sh"]  

