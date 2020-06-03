FROM ubuntu

MAINTAINER Jay Narhan <jay@aidanalytics.org>

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
  && rm -rf /var/lib/apt/lists/*

RUN curl -qsSLkO \
    https://repo.continuum.io/miniconda/Miniconda-latest-Linux-`uname -p`.sh \
  && bash Miniconda-latest-Linux-`uname -p`.sh -b \
  && rm Miniconda-latest-Linux-`uname -p`.sh

ENV PATH=/root/miniconda2/bin:$PATH

RUN conda install -y \
    scipy \
    numpy \
    h5py \
    pandas \
    theano \
    jupyter \
    matplotlib \
    pillow \
    tqdm \
    opencv \
    scikit-learn \
    scikit-image \
  && conda clean --yes --tarballs --packages --source-cache \
  && pip install --upgrade -I setuptools \
  && pip install --upgrade \
    keras \
    https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0rc0-cp27-none-linux_x86_64.whl

# Expose Ports for Ipython (8888)
EXPOSE 8888

WORKDIR "/root"
CMD ["/bin/bash"]