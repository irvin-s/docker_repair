FROM debian:jessie  
MAINTAINER Kolja Dummann <kolja.dummann@logv.ws>  
RUN apt-get update  
RUN apt-get install -y python python-setuptools ca-certificates openssh-client  
RUN apt-get clean  
RUN apt-get autoremove  
RUN easy_install requests  
ADD ./server.py /server.py  
EXPOSE 8001  
ENTRYPOINT ["python", "/server.py"]  
VOLUME ["/scripts"]

