FROM ubuntu:16.04  
MAINTAINER Abdul Somat Budiaji "abdulbudiaji@gmail.com"  
RUN apt-get update && apt-get install -y \  
gcc g++ gfortran \  
python3 python3-dev python3-pip \  
\--no-install-recommends  
  
RUN pip3 install --upgrade pip  
  
# setuptools required to install matplotlib  
RUN pip3 install setuptools  
  
#freetype and png is required by matplotlib  
RUN apt-get install -y \  
libpng12-dev libfreetype6-dev pkg-config \  
\--no-install-recommends  
  
RUN pip3 install numpy  
RUN pip3 install scipy  
RUN pip3 install matplotlib  
  
# install frequently used locale  
RUN locale-gen id_ID.utf8  
RUN locale-gen en_US.utf8  
RUN update-locale  
  
ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8  
# install pyhspf  
RUN pip3 install pyhspf  
  
# clean up  
RUN rm -rf /root/.cache/pip  
RUN rm -rf /var/lib/apt/lists/*  

