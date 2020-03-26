# docker run -p 0.0.0.0:57575:57575 creack/butterfly  
FROM ubuntu:13.10  
MAINTAINER Guillaume J. Charmes <guillaume@charmes.net>  
  
RUN apt-get update  
RUN apt-get install --fix-missing -y python python-pip  
RUN pip install butterfly  
RUN echo "root:1234"|chpasswd  
CMD butterfly.server.py --host=0.0.0.0 --debug  

