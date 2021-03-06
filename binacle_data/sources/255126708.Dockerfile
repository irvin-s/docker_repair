FROM redis_cpu:latest
LABEL maintainer="Erwan BERNARD https://github.com/edmBernard/DockerFiles"

ENV CHAINER_DIR "$LIB_DIR/chainer"
ENV CHAINERRL_DIR "$LIB_DIR/chainerrl"
ENV CHAINERCV_DIR "$LIB_DIR/chainercv"

RUN pip3 --no-cache-dir install -U cython

# Clone chainer repo
RUN cd "$LIB_DIR" && git clone https://github.com/chainer/chainer.git

# Install chainer package
RUN cd "$CHAINER_DIR" && python3 setup.py install

# Clone chainerrl repo
RUN cd "$LIB_DIR" && git clone https://github.com/chainer/chainerrl.git

# Install chainer package
RUN cd "$CHAINERRL_DIR" && python3 setup.py install

# Clone chainercv repo
RUN cd "$LIB_DIR" && git clone https://github.com/chainer/chainercv.git

# Install chainer package
RUN cd "$CHAINERCV_DIR" && python3 setup.py install

CMD ["/bin/bash"]
