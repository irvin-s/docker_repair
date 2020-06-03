FROM nacyot/ubuntu

RUN apt-get install -y libzmq3 python3 python3-pip 
RUN pip3 install ipython==1.1.0 jinja2 tornado pyzmq
RUN \
  ln -s /usr/bin/python3 /usr/bin/python && \
  ln -s /usr/local/bin/ipython3 /usr/local/bin/ipython

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --ip=0.0.0.0 --notebook-dir=/root/notebooks
