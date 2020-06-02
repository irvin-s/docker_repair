FROM python:3.6  
MAINTAINER callsamleung@gmail.com  
  
  
ADD . /srv/wxtransfer  
WORKDIR /srv/wxtransfer  
RUN python setup.py install  
CMD ["wxpytransfer"]  

