FROM nacyot/scala-scala:2.11.1

RUN \
  apt-get update &&\
  apt-get install -y libzmq3 libzmq3-dev python3 python3-pip libmagickwand-dev &&\
  pip3 install ipython==1.1.0 jinja2 tornado pyzmq &&\
  rm /usr/bin/python &&\ 
  ln -s /usr/bin/python3 /usr/bin/python &&\
  ln -s /usr/local/bin/ipython3 /usr/local/bin/ipython

WORKDIR /root
RUN \
  wget https://github.com/mattpap/IScala/releases/download/v0.1/IScala-0.1.tgz &&\
  tar xvf /root/IScala-0.1.tgz &&\
  mv /root/IScala-0.1 /root/iscala

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --KernelManager.kernel_cmd='["java", "-jar", "/root/iscala/lib/IScala.jar", "--profile", "{connection_file}", "--parent"]' --ip=0.0.0.0 --notebook-dir=/root/notebooks

