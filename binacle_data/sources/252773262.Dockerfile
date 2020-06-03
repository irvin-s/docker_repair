FROM python:2.7  
COPY requirements.txt /tmp/requirements.txt  
RUN pip install -r /tmp/requirements.txt  
  
COPY dynamodb-cleanup.py /usr/local/bin/dynamodb-cleanup  

