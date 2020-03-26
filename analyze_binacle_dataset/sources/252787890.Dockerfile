FROM fedora  
  
MAINTAINER cedric.olivier@free.fr  
  
RUN yum install -y \  
libffi-devel \  
git \  
python \  
python-setuptools \  
python-pip \  
python-devel \  
openssl-devel \  
gcc  
  
RUN git clone https://github.com/ronreiter/webmux.git  
  
RUN cd webmux && python setup.py install  
  
EXPOSE 8080  
CMD ["/usr/bin/webmuxd"]  
  

