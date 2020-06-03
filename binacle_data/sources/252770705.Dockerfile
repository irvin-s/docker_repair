FROM amazonlinux:with-sources  
MAINTAINER Marc Rosenthal <marc@affordabletours.com>  
RUN curl -O https://bootstrap.pypa.io/get-pip.py  
RUN python get-pip.py \--user  
ENV PATH /root/.local/bin:$PATH  
RUN pip install awsebcli \--upgrade \--user  
RUN yum -y install git  

