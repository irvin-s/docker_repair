FROM ubuntu:16.04
MAINTAINER Cat.1 docker@gansi.me

RUN apt-get update
RUN apt-get install -y python3-pip
RUN apt-get install -y python3 python-dev python3-dev \
     build-essential libssl-dev libffi-dev \
     libxml2-dev libxslt1-dev zlib1g-dev

RUN apt-get install -y locales
RUN locale-gen zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
ENV PYTHONIOENCODING=utf-8

RUN mkdir -p /freeFileServer/
ADD requirements.txt /freeFileServer/
RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple -r /freeFileServer/requirements.txt

ADD freeFileServer.py /freeFileServer/
WORKDIR /freeFileServer

EXPOSE 65527

CMD python3 ./freeFileServer.py

