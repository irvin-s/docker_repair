FROM centos:latest  
MAINTAINER Anthony Schneider "https://github.com/anthonyserious"  
ENV USERID 5001  
RUN groupadd -g $USERID okdataset  
RUN useradd -u $USERID -g okdataset okdataset  
  
RUN yum install -y gcc python-devel python-setuptools \  
&& yum clean all \  
&& mkdir /okdataset \  
&& chown okdataset /okdataset \  
&& easy_install pip  
  
ADD . /okdataset  
  
RUN pip install -r /okdataset/requirements.txt \  
&& cp /okdataset/server /usr/bin \  
&& cp /okdataset/worker /usr/bin  
  
VOLUME [ "/pylibs" ]  
  

