FROM ubuntu:latest  
RUN apt-get update  
RUN apt-get install -y git  
WORKDIR /base  
ADD . /base  
CMD ["/base/app/command.sh"]  

