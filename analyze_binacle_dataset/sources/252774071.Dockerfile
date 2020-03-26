FROM python:2.7.10  
MAINTAINER Eric Chapman  
  
ENV CROSSBAR_VERSION 0.11.1  
EXPOSE 8080 8081  
RUN apt-get update -y  
RUN apt-get install -y python-pip  
  
RUN pip install \  
crossbar==${CROSSBAR_VERSION}  
  
RUN pip install msgpack-python  
  
COPY .crossbar /.crossbar  
COPY www /www  
  
ENTRYPOINT ["crossbar", "start"]  

