FROM ubuntu:trusty  
MAINTAINER Charlie Lewis  
  
RUN apt-get update  
RUN apt-get install -y python-setuptools  
RUN apt-get install -y git  
RUN easy_install pip  
RUN mkdir /bowl  
ADD . /bowl  
  
RUN pip install -r /bowl/requirements.txt  
RUN cd /bowl; python setup.py install  
  
WORKDIR /bowl  
  
ENTRYPOINT ["/usr/local/bin/bowl"]  
CMD ["-h"]  

