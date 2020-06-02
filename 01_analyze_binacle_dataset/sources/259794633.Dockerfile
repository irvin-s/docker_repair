FROM ubuntu:14.04

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# update
RUN DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get upgrade -y

# apt packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo zsh cron man git emacs wget screen bzip2 curl dnsutils gawk net-tools netcat inetutils-ping unzip \
    make build-essential gcc python-dev g++ libfreetype6 libfontconfig libpq-dev libspatialindex-dev libfreetype6-dev libffi-dev

# node
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
  apt-get install nodejs

# pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o "get-pip.py" && \
  python get-pip.py

# yarn
RUN npm install -g yarn

# python packages
RUN sudo pip install virtualenv arrow==0.6.0 click==5.1 PyYAML==3.12 rethinkdb==2.3.0.post6

# kubernetes cli
RUN curl -O http://storage.googleapis.com/kubernetes-release/release/v1.2.3/bin/linux/amd64/kubectl && \
  chmod +x kubectl && mv kubectl /usr/local/bin/
