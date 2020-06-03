# Mozilla Push Messages API Server  
# VERSION 0.1  
FROM python:2  
EXPOSE 8000  
CMD ["./bin/run-prod.sh"]  
  
MAINTAINER Ben Bangert <bbangert@mozilla.com>  
  
WORKDIR /app  
  
RUN groupadd --gid 10001 app && \  
useradd --uid 10001 --gid 10001 --shell /usr/sbin/nologin app  
  
# Copy requirements for install while additional bits are around  
COPY requirements.txt /app/requirements.txt  
RUN pip install -r requirements.txt  
  
# Copy in the app  
COPY . /app  
  
# Setup the app  
RUN python setup.py develop  
  
USER app  

