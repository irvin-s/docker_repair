FROM andrioni/base  
  
# Many thanks to Mike Babineau <mike@thefactory.com>  
MAINTAINER Alessandro Andrioni <alessandro.andrioni@dafiti.com.br>  
  
RUN apt-get -y install python=2.7.* python-pip  
  
ADD . /opt/marathon-logger  
RUN pip install -r /opt/marathon-logger/requirements.txt  
  
EXPOSE 5000  
ENTRYPOINT ["/opt/marathon-logger/marathon-logger.py", "-p", "5000"]  
CMD "-h"  

