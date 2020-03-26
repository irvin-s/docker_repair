FROM nacyot/go-go:1.3

RUN \
  apt-get update && \
  apt-get install -y libzmq3 libzmq3-dev python python-pip mercurial pkg-config \
    python-zmq python-jinja2 python-tornado python && \
  pip install ipython

ENV GOPATH /root/.go
RUN \
  go get -tags zmq_3_x github.com/alecthomas/gozmq  && \
  go get github.com/takluyver/igo && \
  ln -s /root/.go/bin/igo /usr/bin/igo

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --KernelManager.kernel_cmd="['igo', '{connection_file}']"  --ip=0.0.0.0 --notebook-dir=/root/notebooks
