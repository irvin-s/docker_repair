FROM ubuntu:14.04  
EXPOSE 5003  
MAINTAINER Chet Carello "cpuskarz@cisco.com"  
VOLUME ["/app/data"]  
  
RUN apt-get update  
RUN apt-get install -y python-pip  
RUN pip install setuptools wheel  
  
ADD . /app  
WORKDIR /app  
RUN pip install -r requirements.txt  
  
CMD ["python", "mydrummer_data.py"]  
  

