FROM ubuntu:xenial  
COPY . /src  
WORKDIR /src  
RUN apt-get update -y  
RUN apt-get install -y python3  
RUN apt-get install -y python3-pip  
RUN pip3 install flask  
RUN pip3 install prometheus_client  
EXPOSE 8080  
RUN python3 unh698_test.py

