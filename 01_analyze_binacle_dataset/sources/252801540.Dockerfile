FROM ubuntu:16.04  
RUN apt-get update && \  
apt-get install -y software-properties-common && \  
add-apt-repository ppa:fkrull/deadsnakes && \  
add-apt-repository ppa:openjdk-r/ppa && \  
apt-get update  
  
RUN apt-get install -y python2.7 python3.5 python3-pip  
RUN apt-get install -y openjdk-7-jdk  
  
RUN mkdir /jury  
COPY requirements.txt /jury/  
WORKDIR /jury  
RUN pip3 install -r requirements.txt  
COPY . /jury/  
  
CMD ["python3", "main.py"]  

