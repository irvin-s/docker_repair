FROM registry.centos.org/dharmit/base  
  
MAINTAINER Dharmit Shah <shahdharmit@gmail.com>  
  
ENV FLASK_APP=hello.py  
  
RUN sudo yum -y update && \  
sudo yum -y install epel-release && \  
sudo yum -y install python-pip && \  
sudo yum clean all && \  
sudo pip install flask  
  
ADD hello.py /hello.py  
  
EXPOSE 5000  
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]  

