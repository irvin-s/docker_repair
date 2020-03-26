FROM therealwardo/python-2.7-pip
MAINTAINER "David Jay <davidgljay@gmail.com>"

RUN apt-get update
RUN pip install mkdocs
RUN pip install mkdocs-cinder
RUN pip install mkdocs-material
RUN apt-get install wget
WORKDIR /s3cmd
RUN wget http://ufpr.dl.sourceforge.net/project/s3tools/s3cmd/1.6.1/s3cmd-1.6.1.tar.gz
RUN tar xzf s3cmd-1.6.1.tar.gz
WORKDIR /s3cmd/s3cmd-1.6.1
RUN python setup.py install
RUN apt-get install git -y
WORKDIR /usr/docs


CMD bash
