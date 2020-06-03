FROM centos:latest  
  
WORKDIR /root/  
ADD ./requirements.txt /root/requirements.txt  
  
RUN yum install gcc gcc-c++ epel-release wget --nogpgcheck -y  
RUN yum install python34 python34-pip python34-devel --nogpgcheck -y  
  
RUN pip3 install numpy scipy  
RUN pip3 install -r /root/requirements.txt  
  
ENV LC_ALL=en_US.utf-8  
ENV LANG=en_US.utf-8  

