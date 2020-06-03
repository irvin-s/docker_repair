FROM ubuntu:14.04  
RUN apt-get update  
RUN apt-get install python -y  
RUN apt-get install python-dev -y  
RUN apt-get install python-pip -y  
RUN pip install awscli  
RUN mkdir -m 775 /data  
ADD run.sh /data/run.sh  
RUN chmod +x /data/run.sh  
WORKDIR /data  
CMD ./run.sh  

