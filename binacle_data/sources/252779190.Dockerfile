FROM ubuntu:16.04  
MAINTAINER Fran Alonso <fran.alonso@byteflair.com>  
  
RUN apt-get update && apt-get install -y \  
ssh \  
rsync \  
sshpass  
  
COPY ["entrypoint.sh", "/"]  
  
ENTRYPOINT ["/entrypoint.sh"]  

