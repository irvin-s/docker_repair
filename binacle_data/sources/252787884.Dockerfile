FROM ubuntu:14.04  
EXPOSE 5000  
MAINTAINER Chet Carello "cpuskarz@cisco.com"  
VOLUME ["/app/data"]  
  
# Install basic utilities  
RUN apt-get update  
RUN apt-get install -y python-pip  
RUN pip install setuptools wheel  
  
ADD . /app  
WORKDIR /app  
RUN pip install -r requirements.txt  
  
CMD ["python", "./sched/app.py"]  
  
# notes  
# more notes  

