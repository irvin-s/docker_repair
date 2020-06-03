FROM python:3.5-alpine  
MAINTAINER Chris Chang  
  
ADD requirements.txt /app/requirements.txt  
RUN pip install --disable-pip-version-check -r /app/requirements.txt  
  
COPY . /app  
WORKDIR /app  
  
VOLUME ["/app/data"]  
  
ENTRYPOINT ["python", "main.py"]  

