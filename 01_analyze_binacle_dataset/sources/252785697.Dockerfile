From phusion/baseimage  
MAINTAINER Jimin Huang "windworship2@163.com"  
ADD sources.list /etc/apt/sources.list  
RUN apt-get update && apt-get install python-pip \  
python-mysqldb \  
python-dev -y  
RUN pip install --default-timeout 6000 tornado torndb  
RUN apt-get remove python-pip -y && apt-get autoremove -y  
EXPOSE 80  
VOLUME ["/server"]  
WORKDIR server  
ENTRYPOINT ["python", "server.py"]  

