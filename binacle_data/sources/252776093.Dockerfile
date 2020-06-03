FROM mesosphere/mesos:0.20.1  
MAINTAINER Ian Babrou <ibobrik@gmail.com>  
  
RUN apt-get install -y curl  
  
ADD ./run.sh /run.sh  
ENTRYPOINT ["/run.sh"]  

