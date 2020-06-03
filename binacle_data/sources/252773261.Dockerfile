# Base the DynamoDB B'n'R docker container on python 2  
FROM python:2.7  
# Add the tool directory  
ADD . /dynamobnr  
  
# Set work directory  
WORKDIR /dynamobnr  
  
# Install the tool and clean the work directory  
RUN \  
python setup.py install && \  
rm -rf /dynamobnr && \  
mkdir /dynamobnr  

