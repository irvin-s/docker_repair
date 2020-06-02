################################################  
#  
# Dockerfile  
# Builds the image required to run this service  
#  
################################################  
  
FROM jazzdd/alpine-flask  
  
MAINTAINER Baldwin Chang <baldwinchang@tycoint.com>  
  
# Install PyPI requirements, faster compile time  
COPY requirements.txt /app/requirements.txt  
RUN pip install --upgrade pip && pip install -r requirements.txt  
  
COPY app/* /app  
  

