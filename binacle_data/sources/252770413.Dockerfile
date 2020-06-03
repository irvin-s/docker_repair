FROM python:3.4-alpine  
  
MAINTAINER Askarr <askarr@use.startmail.com>  
  
RUN apk add --no-cache g++  
  
# Create non-root user  
RUN adduser -D eddn  
  
COPY requirements.txt /tmp/  
RUN pip install --no-cache-dir -r /tmp/requirements.txt  
  
USER eddn  
  
RUN mkdir /home/eddn/eddn-raw-feed/  
COPY /. /home/eddn/eddn-raw-feed/  
WORKDIR /tmp  
  
CMD [ "python", "/home/eddn/eddn-raw-feed/eddn-dynamo-raw.py", "-i" ]

