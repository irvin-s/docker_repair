FROM behance/docker-base:latest  
MAINTAINER Michael Klein <klein@adobe.com>  
  
# Prepare packaging environment  
ENV DEBIAN_FRONTEND noninteractive  
  
# Workaround for bug: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=807948  
RUN chmod 0777 /tmp  
  
# Update and install package dependencies  
RUN apt-get update && apt-get install -y \  
software-properties-common \  
build-essential \  
libncursesw5-dev \  
libreadline6-dev \  
libssl-dev \  
libgdbm-dev \  
libc6-dev \  
libsqlite3-dev \  
tk-dev \  
libbz2-dev \  
liblzma-dev \  
libjpeg-dev \  
wget \  
git  
  
# Install python 3.5  
ENV PYTHONHOME=/usr/local  
  
RUN cd /tmp && \  
wget https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tgz && \  
tar xvf Python-3.5.1.tgz && \  
cd Python-3.5.1 && \  
./configure --prefix=/usr/local \--enable-shared && \  
make install && \  
ldconfig /usr/local/lib  
  
# Create and configure python virtual environment  
COPY ./requirements.txt /tmp  
RUN python3 -m venv /.venv && \  
/bin/bash -c "source /.venv/bin/activate && \  
pip install --upgrade pip && \  
pip install -r /tmp/requirements.txt && \  
aws configure set default.s3.signature_version s3v4"  
  
# Clean up  
RUN apt-get autoclean -y && \  
apt-get autoremove -y && \  
rm -rf /tmp/* /var/tmp/* && \  
rm -rf /var/lib/apt/lists/*  

