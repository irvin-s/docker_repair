FROM ubuntu:14.04  
RUN apt-get update \  
&& apt-get install -y python  
  
COPY . /app  
  
CMD ["python", "/app/example.py"]  

