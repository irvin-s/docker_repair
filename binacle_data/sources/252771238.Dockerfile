FROM deliverous/graphite-beacon  
MAINTAINER Ainsley Chong <ainsley.chong@gmail.com>  
  
# Get curl  
RUN apt-get update  
RUN apt-get -y install curl  
  
# Add init script  
ADD ./init.sh /sbin/init.sh  
  
CMD ["/sbin/init.sh"]  

