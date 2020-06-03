FROM ubuntu:latest  
MAINTAINER Andy Yates "andy yates at ebi"  
RUN apt-get update -y  
RUN apt-get install -y python-pip python-dev build-essential  
COPY . /app  
WORKDIR /app  
RUN pip install -r requirements.txt  
ENTRYPOINT ["python"]  
CMD ["date.py"]  

