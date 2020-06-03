FROM ubuntu:12.04  
MAINTAINER Oliver Letterer <oliver.letterer@sparrow-labs.de>  
  
RUN apt-get update  
RUN apt-get upgrade -y  
  
RUN apt-get install -y python-pip python-dev build-essential && apt-get clean  
RUN pip install automated-ebs-snapshots  
  
ADD run.sh /run.sh  
RUN chmod +x /run.sh  
  
CMD ["/run.sh"]  

