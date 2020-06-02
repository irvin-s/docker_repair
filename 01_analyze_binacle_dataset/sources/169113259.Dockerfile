FROM nacyot/ubuntu

RUN apt-get install -y libzmq3 python3 python3-pip 
RUN pip3 install ipython jinja2 tornado pyzmq
RUN \
  ln -s /usr/bin/python3 /usr/bin/python

RUN \
  cd $(ipython locate) &&\
  git clone https://github.com/Carreau/profile_jskernel

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --ip=0.0.0.0 --notebook-dir=/root/notebooks --profile jskernel
