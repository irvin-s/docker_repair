FROM ubuntu:trusty
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update && apt-get -yq upgrade
RUN apt-get -yq install gcc make curl zlib1g-dev libssl-dev groff
RUN cd /usr/local/src \
  && curl -sSL https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz | tar zx \
  && cd Python-2.7.8 \
  && ./configure && make && make install \
  && cd /tmp \
  && curl -O https://bootstrap.pypa.io/get-pip.py && python /tmp/get-pip.py \
  && rm -rf /usr/local/src/Python-2.7.8 /tmp/get-pip.py
RUN pip install awscli
WORKDIR /container
ENTRYPOINT ["aws"]
