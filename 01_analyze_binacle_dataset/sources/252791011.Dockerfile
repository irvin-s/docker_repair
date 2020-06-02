FROM ubuntu:14.04.3  
MAINTAINER custa <custa@126.com>  
  
ENV REFRESHED_AT 2015-12-23  
RUN apt-get -y update && \  
apt-get -y install curl && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists  
  
ADD eval.sh /eval.sh  
RUN chmod +x /eval.sh  
  
ENTRYPOINT ["/eval.sh"]  

