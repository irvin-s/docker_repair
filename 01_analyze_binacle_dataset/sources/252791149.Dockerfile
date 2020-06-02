FROM python:2.7  
MAINTAINER Jeff Terstriep <jefft@illinois.edu>  
  
ADD . /app  
WORKDIR /app  
RUN pip install -r requirements.txt  
RUN python setup.py install  
  
CMD ["topolens_handler", "--help"]  

