FROM ubuntu:14.04  
MAINTAINER Hong Minhee <hong.minhee@gmail.com>  
RUN apt-get update && \  
apt-get install -y build-essential curl && \  
rm -rf /var/lib/apt/lists/*  
  
COPY patch.diff /tmp/  
RUN curl -sL https://www.python.org/ftp/python/src/py152.tgz | tar xvfz - && \  
cd Python-1.5.2/ && \  
patch -p1 < /tmp/patch.diff && \  
./configure && \  
make && \  
make install && \  
cd .. && \  
rm -rf Python-1.5.2/  
  
CMD python  

