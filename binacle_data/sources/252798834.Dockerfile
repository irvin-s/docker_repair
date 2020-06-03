FROM ubuntu:16.04  
RUN apt-get update  
COPY . /opt/cmis-capture  
WORKDIR /opt/cmis-capture  
RUN /opt/cmis-capture/extern/ubuntu_install.sh  
RUN /opt/cmis-capture/extern/install_zxing.sh  
  
EXPOSE 5000  
CMD python /opt/cmis-capture/web.py  

