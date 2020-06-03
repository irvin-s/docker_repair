FROM nacyot/ubuntu

RUN apt-get install -y libzmq3 python3 python3-pip 
RUN pip3 install git+https://github.com/ipython/ipython.git jinja2 tornado pyzmq jsonschema
RUN \
  ln -s /usr/bin/python3 /usr/bin/python

RUN \
  mkdir -p $( ipython locate )/kernels && \
  cd $( ipython locate )/kernels && \
  git clone  https://github.com/nacyot/jskernel

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --ip=0.0.0.0 --notebook-dir=/root/notebooks
