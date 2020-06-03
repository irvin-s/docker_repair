FROM nacyot/r-r:apt

RUN \
  apt-get update &&\
  apt-get install -y libzmq3 libzmq3-dev python3 python3-pip libmagickwand-dev libcurl4-openssl-dev &&\
  pip3 install ipython==1.1.0 jinja2 tornado pyzmq &&\
  rm /usr/bin/python &&\ 
  ln -s /usr/bin/python3 /usr/bin/python &&\
  ln -s /usr/local/bin/ipython3 /usr/local/bin/ipython

ADD ./init.R /root/init.R
RUN \
  chmod +x /root/init.R &&\
  /root/init.R  

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --KernelManager.kernel_cmd="['R', '-e', 'IRkernel::main()', '--args', '{connection_file}']" --ip=0.0.0.0 --notebook-dir=/root/notebooks
