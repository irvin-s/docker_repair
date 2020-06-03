FROM ubuntu:latest  
MAINTAINER Davidsito "djguzmanc@unal.edu.co"  
RUN apt-get update -y  
RUN apt-get install -y python-pip python-dev build-essential  
COPY . /app  
WORKDIR /app  
RUN pip install Flask  
RUN pip install couchdb  
ENTRYPOINT ["python"]  
CMD ["main.py"]  

