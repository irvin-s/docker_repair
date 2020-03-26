FROM ubuntu:quantal  
MAINTAINER Lucas Carlson <lucas@rufy.com>  
  
# Let's get serf  
RUN apt-get update -q  
RUN apt-get install -qy unzip  
ADD https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip serf.zip  
RUN unzip serf.zip  
RUN rm serf.zip  
RUN mv serf /usr/bin/  
ADD /start-serf.sh /start-serf.sh  
ADD /serf-join.sh /serf-join.sh  
ADD /run.sh /run.sh  
RUN chmod 755 /*.sh  
  
EXPOSE 7946 7373  
CMD ["/run.sh"]  

