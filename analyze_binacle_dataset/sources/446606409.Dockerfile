FROM ubuntu:precise
MAINTAINER Pini Reznik <p.reznik@uglyduckling.nl>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y openjdk-7-jre-headless firefox xvfb 
RUN apt-get install -y build-essential python-dev python-setuptools

RUN easy_install pip
RUN pip install --upgrade distribute

RUN pip install -U selenium

