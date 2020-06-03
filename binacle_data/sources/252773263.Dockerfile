FROM python:2.7  
RUN pip install lxml requests  
  
COPY xunitbucket.py /usr/local/bin/xunitbucket  

