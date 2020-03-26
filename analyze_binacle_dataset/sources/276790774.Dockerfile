FROM ubuntu:latest
MAINTAINER Judit Acs

WORKDIR /nlp

RUN apt-get update \
        && apt-get install -y python3-pip python3-dev \
        && cd /usr/local/bin \
        && ln -s /usr/bin/python3 python \
        && pip3 install --upgrade pip
RUN apt-get install -y wget git unzip less
RUN pip3 install numpy scipy nltk jupyter
RUN python -c 'import nltk;nltk.download("wordnet")'

RUN mkdir /nlp/hfst && cd /nlp/hfst && wget http://apertium.projectjj.com/apt/nightly/pool/main/h/hfst/libhfst49_3.13.0~r3459-0ubuntu1~xenial1_amd64.deb && dpkg -i libhfst49_3.13.0~r3459-0ubuntu1~xenial1_amd64.deb
RUN cd /nlp/hfst && wget http://apertium.projectjj.com/apt/nightly/pool/main/h/hfst/hfst_3.13.0~r3459-0ubuntu1~xenial1_amd64.deb && dpkg -i hfst_3.13.0~r3459-0ubuntu1~xenial1_amd64.deb

RUN cd /nlp/hfst && wget http://sandbox.mokk.bme.hu/~judit/resources/hu.hfstol

RUN cd /nlp && git clone https://github.com/bmeaut/python_nlp_2017_fall.git

RUN apt-get install -y zlib1g-dev flex subversion
RUN git clone https://github.com/mhulden/foma.git

RUN apt-get install -y bison
RUN apt-get install -y libreadline6 libreadline6-dev

RUN cd foma/foma && make && make install

RUN apt-get install -y graphviz
RUN pip3 install sklearn

EXPOSE 8888
