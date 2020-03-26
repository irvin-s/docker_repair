FROM python:3.6.4-slim-stretch  
LABEL maintainer "Johann Bauer (https://bauerj.eu/)"  
  
RUN mkdir /data && mkdir /app  
COPY . /app  
WORKDIR /app  
  
RUN apt-get update && \  
apt-get install -y libleveldb-dev build-essential && \  
rm -rf /var/lib/apt/lists/*  
  
RUN pip install -r requirements.txt  
  
VOLUME ["/data"]  
ENV DB_PATH=/data  
  
CMD ["python", "cosignerpool.py"]  
  
EXPOSE 80

