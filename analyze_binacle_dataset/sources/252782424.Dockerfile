FROM centos:7  
RUN yum update -y && yum clean all  
RUN yum install -y gcc-c++ patch python python-devel tar  
RUN curl https://bootstrap.pypa.io/get-pip.py | python && \  
pip install --upgrade setuptools  
RUN mkdir /tmp/thrift-4042  
ADD . /tmp/thrift-4042  
WORKDIR /tmp/thrift-4042  
RUN python setup.py install  
CMD ["python", "-m", "thrift4042"]  

