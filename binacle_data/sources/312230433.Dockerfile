FROM tensorflow/tensorflow:1.12.0-gpu-py3
# According to docker inspect:
# CUDA_VERSION=9.0.176

LABEL description="Prebuilt jupyter environment based on official GPU-supported tensorflow docker image." \
      maintainer="https://github.com/rlan/notebooks"

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/rlan/notebooks" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends \
        graphviz \
        libhdf5-dev \
        vim \
        wget \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip --no-cache-dir install -q --upgrade pip \
    && pip --no-cache-dir install -q -U \
        h5py \
        jupyterlab \
        keras \
        opencv-python-headless \
        pydot \
        pyyaml \
        scikit-image

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR /notebooks
