FROM badoque/alpine-python:latest  
  
RUN apk add --no-cache \  
postgresql-dev \  
nodejs=4.3.0-r0  
  
RUN npm install -g \  
less \  
bower \  
gulp  
  
RUN mkdir /tmp/env  
  
COPY requirements.txt /tmp/env/requirements.txt  
  
RUN pip install -r /tmp/env/requirements.txt

