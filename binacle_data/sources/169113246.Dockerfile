FROM nacyot/ubuntu

RUN \
  apt-get update &&\
  apt-get install -y libzmq3 python python-pip python-zmq python-jinja2 python-tornado python &&\
  pip install ipython==1.1.0

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --ip=0.0.0.0 --notebook-dir=/root/notebooks
