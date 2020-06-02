# alpine variant doesn't work with a strange error in pip install  
FROM python:3.5  
MAINTAINER crccheck  
  
COPY requirements.txt /app/requirements.txt  
WORKDIR /app  
RUN pip install --quiet --disable-pip-version-check -r requirements.txt  
COPY . /app  
  
VOLUME /data/geodude  
ENV DATA_DIR /data/geodude  
  
EXPOSE 8080  
HEALTHCHECK CMD curl -f http://localhost:8080/metrics  
  
CMD ["python", "server.py"]  

