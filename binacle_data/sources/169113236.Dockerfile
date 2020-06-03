FROM nacyot/erlang-erlang:apt

RUN \
  apt-get update &&\
  apt-get install -y libzmq3 libzmq3-dev python python-pip mercurial pkg-config &&\
  apt-get install -y python-zmq python-jinja2 python-tornado python &&\
  pip install ipython==2.0.0

RUN mkdir -p /root/ierlang-dev

RUN git clone http://github.com/robbielynch/ierlang.git /root/ierlang-dev/ierlang

RUN \
  git clone http://github.com/zeromq/erlzmq2.git /root/ierlang-dev/erlzmq2 &&\
  cd /root/ierlang-dev/erlzmq2 &&\
  make &&\
  make docs &&\
  make test

RUN \
  rm /usr/local/lib/python2.7/dist-packages/IPython/kernel/zmq/session.py &&\
  cp /root/ierlang-dev/ierlang/ipython_edited_files/session.py /usr/local/lib/python2.7/dist-packages/IPython/kernel/zmq/session.py

ENV HOME /root
ENV ERL_LIBS /root/ierlang-dev/erlzmq2:$ERL_LIBS
ENV PATH $PATH:$ERL_LIBS

VOLUME /root/notebooks
ADD ./run.sh /root/ierlang-dev/ierlang/src/start-ierl-notebook.sh
RUN chmod +x /root/ierlang-dev/ierlang/src/start-ierl-notebook.sh
WORKDIR /root/ierlang-dev/ierlang/
EXPOSE 8888
CMD bash -c "./ierlang-notebook.sh"
