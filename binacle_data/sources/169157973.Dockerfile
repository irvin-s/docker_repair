FROM ubuntu:14.04
MAINTAINER gopass2002@gmail.com

# install packages
RUN apt-get update && apt-get install -y build-essential python-pip python-dev

# make dir pharos home
RUN mkdir -p /pharos/usr
ADD ./requirements.txt /tmp/requirements.txt

# install python packages
RUN pip install --install-option="--prefix=/pharos/usr" -r /tmp/requirements.txt
#RUN pip install --install-option="--prefix=/pharos/usr" pymongo && pip install --install-option="--prefix=/pharos/usr" docker-py && pip install --install-option="--prefix=/pharos/usr" psutil && pip install --install-option="--prefix=/pharos/usr" numpy && pip install --install-option="--prefix=/pharos/usr" zerorpc

# copy sources
ADD . /pharos/.

# export PYTHONPATH
ENV PYTHONPATH /pharos/src/python:/pharos/usr/lib/python2.7/site-packages

CMD /pharos/bin/lightkeeper
