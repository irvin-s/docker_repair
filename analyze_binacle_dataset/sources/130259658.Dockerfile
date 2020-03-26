############################################################
# Dockerfile to build kifu, a minimal web application based on Pyramid, Bootstrap, Redis, Rabbit MQ, Supervisor
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Michael Hanna

# Update the repository sources list
# And set up compilation environment
RUN apt-get update && apt-get install -y \
    gcc \
    git \
    python \
    python-dev \
    libffi-dev \
    build-essential \
    curl \
    libbz2-dev \
    libexpat-dev \
    nginx \
    tcl8.5 \
    rabbitmq-server \
    redis-server

#    redis \
#    rabbitmq

RUN mkdir kifu_install
WORKDIR kifu_install

# expose port for redis-server
# EXPOSE 6379

# expose port for rabbitmq-server
# EXPOSE 15672

# get and install virtualenv
RUN curl -O https://pypi.python.org/packages/source/v/virtualenv/virtualenv-13.1.1.tar.gz
RUN ls
RUN tar zxvf virtualenv-13.1.1.tar.gz
RUN cd virtualenv-13.1.1 && python setup.py install


RUN curl -O http://pyyaml.org/download/pyyaml/PyYAML-3.11.tar.gz
RUN tar zxvf PyYAML-3.11.tar.gz
RUN cd PyYAML-3.11 && python setup.py install


RUN git clone https://github.com/wcdolphin/python-bcrypt.git
RUN cd python-bcrypt && python setup.py install

# RUN redis-server
# RUN rabbitmq-server

RUN git clone https://github.com/mazz/kifu.git
RUN mkdir webapp && cd kifu && ./kifu.py -n foo -s -d ../webapp 

