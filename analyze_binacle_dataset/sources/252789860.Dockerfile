FROM python:3.6  
MAINTAINER callsamleung@gmail.com  
  
  
ADD . /srv/wxcheckin  
WORKDIR /srv/wxcheckin  
RUN python setup.py install  
CMD ["wxcheckin"]  

