FROM nacyot/ubuntu
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

RUN apt-get -y update
RUN apt-get -y install python python-twisted

WORKDIR /usr/local/src

RUN git clone https://github.com/graphite-project/carbon.git
RUN git clone https://github.com/graphite-project/whisper.git
RUN cd whisper && git checkout master && python setup.py install
RUN cd carbon && git checkout 0.9.12 && python setup.py install

