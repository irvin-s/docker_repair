FROM ubuntu:14.04  
MAINTAINER Ken Huang <ken@after4u.com>  
  
# environment  
ENV DEBIAN_FRONTEND noninteractive  
  
# update  
RUN apt-get update && apt-get -y upgrade  
  
RUN apt-get -y install curl wget zip bzip2 vim git supervisor  
  
ADD etc/supervisord.conf /etc/supervisord.conf  
ADD run.sh /run.sh  
RUN chmod 755 /*.sh  
  
CMD ["/run.sh"]

