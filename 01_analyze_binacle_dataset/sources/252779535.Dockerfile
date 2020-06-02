FROM ubuntu:latest  
MAINTAINER Sayan "kurogane2010@yandex.ru"  
RUN apt-get update -y  
RUN apt-get install -y python3-pip  
RUN pip3 install flask  
ENTRYPOINT ["python3"]  
CMD ["main.py"]  

