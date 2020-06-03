FROM nacyot/ubuntu:latest

RUN \
  apt-get update &&\
  apt-get install -y libzmq3 libzmq3-dev python3 python3-pip libmagickwand-dev &&\
  pip3 install jinja2 tornado pyzmq pexpect jsonschema &&\
  rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python &&\
  ln -s /usr/local/bin/ipython3 /usr/local/bin/ipython

RUN \
  git clone --recursive https://github.com/ipython/ipython.git /root/ipython/ &&\
  cd /root/ipython &&\
  python setup.py install

RUN \
  git clone https://github.com/takluyver/bash_kernel.git /root/bash_kernel &&\
  cd /root/bash_kernel &&\
  python setup.py install

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython console --kernel=bash
