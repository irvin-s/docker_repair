FROM ubuntu:16.04  
MAINTAINER Brian Williams  
  
RUN apt-get update && \  
apt-get install -y \  
python-pip \  
python-dev \  
gcc \  
phantomjs \  
build-essential \  
libssl-dev \  
libffi-dev  
  
# Put files in container and install  
COPY / /home/build  
RUN pip install /home/build && \  
rm -r /home/build  
  
CMD ["python"]  

