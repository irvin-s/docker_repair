FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TERM=xterm-color
ENV CAFFE_ROOT=/nsfw/caffe
WORKDIR $CAFFE_ROOT
ENV CLONE_TAG=1.0
ENV JIVESEARCH_CRAWLER_USERAGENT_FULL https://github.com/jivesearch/jivesearch
ENV NSFW_ADDR 0.0.0.0
ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libmagic1 \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    protobuf-compiler \
    python-dev \
    python-opencv \
    python-numpy \
    python-pip \
    python-setuptools \
    python-scipy \
    python-skimage \
    unzip \
    wget && \
  # Note: tensorflow version 1.6 gives "Illegal instruction" error
  pip install --upgrade --user pip==9.0.3 && \
  pip install bottle \
    gevent \
    gunicorn \
    python-magic \
    requests \
    tensorflow==1.5 \
    wheel && \
  git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . && \
  cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
  mkdir build && cd build && \
  cmake -DCPU_ONLY=1 .. && \
  make -j"$(nproc)" && \
  echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && \
  ldconfig

WORKDIR /nsfw
RUN wget --no-check-certificate https://raw.githubusercontent.com/jivesearch/jivesearch/master/search/image/cmd/classifier.py

ENV NSFW_MODEL 5005730b-eff1-4700-a553-c13f9bc97a53_nsfw_model.zip
ENV NSFW_MODEL_URL https://modeldepot.io/assets/uploads/models/models/$NSFW_MODEL
ENV INCEPTION_MODEL inception-2015-12-05.tgz
ENV INCEPTION_MODEL_URL http://download.tensorflow.org/models/image/imagenet/$INCEPTION_MODEL

RUN wget $NSFW_MODEL_URL && \
  unzip $NSFW_MODEL && \
  wget $INCEPTION_MODEL_URL && \
  tar -xvzf $INCEPTION_MODEL

EXPOSE 8080
CMD ["python", "classifier.py"]