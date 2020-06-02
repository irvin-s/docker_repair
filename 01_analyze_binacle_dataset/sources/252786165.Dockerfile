FROM ubuntu:trusty  
MAINTAINER Dmitrii Ageev <d.ageev@gmail.com>  
  
# Set environment  
ENV APPLICATION "pycharm"  
ENV VERSION "2017.3.2"  
ENV FILE "pycharm-community-${VERSION}.tar.gz"  
ENV LINK "https://download.jetbrains.com/python/${FILE}"  
ENV EXECUTABLE "/pycharm-community-${VERSION}/bin/pycharm.sh"  
  
# Install software package  
RUN apt update  
RUN apt install --no-install-recommends -y \  
sudo \  
curl \  
cython \  
cython3 \  
git \  
gzip \  
ipython \  
ipython3 \  
libgif4 \  
libxrender1 \  
libxslt1.1 \  
libxtst6 \  
openjdk-7-jre \  
openssh-client \  
python \  
python-coverage \  
python-pip \  
python-pytest \  
python-setuptools \  
python-tox \  
python3 \  
python3-coverage \  
python3-setuptools \  
python3-pip \  
python3-pytest  
  
RUN curl -kL -O "${LINK}"  
RUN tar xvzf ./${FILE}  
  
# Remove unwanted stuff  
RUN rm -f ./${FILE}  
RUN apt purge -y --auto-remove curl  
  
# Copy scripts and pulse audio settings  
COPY files/wrapper /sbin/wrapper  
COPY files/entrypoint.sh /sbin/entrypoint.sh  
COPY files/pulse-client.conf /etc/pulse/client.conf  
  
# Proceed to the entry point  
ENTRYPOINT ["/sbin/entrypoint.sh"]  

