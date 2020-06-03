FROM ubuntu:15.04

#RUN echo "deb ftp://mirror.hetzner.de/ubuntu/packages precise main restricted universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# basic tools
RUN apt-get install -y openssh-server git-core curl wget vim-tiny build-essential python3-dev python3-setuptools

# compilers
RUN apt-get install -y gfortran build-essential make gcc build-essential

# install python
RUN apt-get install -y python3.4 python3.4-dev python3-pip

# python-PIL
RUN apt-get install -y python3-pil
RUN apt-get install -y python3-httplib2 ipython3
RUN apt-get install -y python3-numpy python3-scipy python3-pip python3-scipy
RUN apt-get install -y libatlas-dev libatlas3gf-base
RUN apt-get install -y python3-skimage python3-matplotlib python3-pandas
RUN apt-get install -y python3-h5py
RUN apt-get install -y python-opencv
RUN pip3 install scikit-learn

EXPOSE 8888
