FROM python:3-alpine  
MAINTAINER Henrik Steen <henrist@henrist.net>  
  
RUN apk --update add \  
ca-certificates  
  
RUN mkdir -p /usr/src/app  
RUN mkdir -p /usr/src/tripletex  
  
COPY tripletex/requirements.txt /usr/src/tripletex/  
COPY tripletex-importer/app/requirements.txt /usr/src/app/  
  
WORKDIR /usr/src/tripletex  
RUN pip install --no-cache-dir -r requirements.txt  
  
WORKDIR /usr/src/app  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY tripletex /usr/src/tripletex  
COPY tripletex-importer/app /usr/src/app  
  
CMD ["./importer.py"]  
  

