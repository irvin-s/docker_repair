FROM python:3.6  
  
RUN apt-get update  
RUN apt-get install -yq nodejs npm  
RUN apt-get clean  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
RUN pip install invoke flake8 pytest pytest-cov markdown pygments numpy  

