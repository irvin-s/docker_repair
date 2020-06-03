FROM centos:7  
MAINTAINER Aagam Shah <aagam@redhat.com>  
  
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm && \  
yum -y install python36u && \  
yum -y install python36u-pip && \  
yum -y install python36u-devel &&\  
yum clean all  
  
COPY ./requirements.txt /  
RUN pip3.6 install -r requirements.txt && rm requirements.txt  
  
COPY ./src /src  
RUN cp /src/config.py.template /src/config.py  
  
ADD scripts/entrypoint.sh /bin/entrypoint.sh  
  
ENTRYPOINT ["/bin/entrypoint.sh"]

