FROM debian:7.7

# Some base commands to set up the image for interactive use
RUN apt-get update
RUN apt-get -y install build-essential \
 python-dev \
 python-setuptools \
 python-psycopg2 \
 python-virtualenv \
 python-pip \
 libpq-dev \
 vim \
 tmux \
 htop \
 git \
 libffi-dev \
 libxml2-dev \
 libxslt1-dev \
 curl \
 abiword

RUN pip install virtualenv
RUN ssh-keyscan -H github.com >> /etc/ssh/ssh_known_hosts
