FROM centos:latest  
  
# Install Node  
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -  
RUN yum -y install nodejs  
RUN yum -y install gcc-c++ make  
  
# Install Python  
RUN yum install gcc  
RUN mkdir /tableau  
COPY Python-2.7.13.tgz /tableau/Python-2.7.13.tgz  
RUN cd /tableau; tar xzf Python-2.7.13.tgz;  
RUN cd /tableau/Python-2.7.13; ./configure; make install  
RUN python -V  
  
# Install Tableau SDK  
COPY setup.py /tableau/setup.py  
COPY tableausdk /tableau/tableausdk  
RUN cd /tableau; python setup.py build  
RUN cd /tableau; python setup.py install  
RUN rm -r /tableau  

