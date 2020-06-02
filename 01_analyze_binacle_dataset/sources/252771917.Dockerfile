FROM atsnngs/radiko-recorder:latest  
MAINTAINER Atsushi Nagase<a@ngs.io>  
  
RUN apt-get update -y && apt-get install -y python-pip curl  
RUN pip install awscli  
ADD rec_radiko3.sh /usr/local/bin/rec_radiko3.sh  
  
ENTRYPOINT /usr/local/bin/rec_radiko3.sh  

