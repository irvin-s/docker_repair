FROM centos:centos7  
  
MAINTAINER Daehyeok Mun "daehyeok@gmail.com"  
RUN yum update -y && yum install epel-release -y && yum install python34 -y  
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py  
RUN pip3 install requests && pip install prettytable  
  
COPY starship.py /starship.py  
  
CMD ["python3", "/starship.py"]  
  
  

