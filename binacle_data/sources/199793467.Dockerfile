FROM nvidia/cuda:7.0-ubuntu14.04
MAINTAINER mdagost@gmail.com

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y 
RUN apt-get install -y software-properties-common curl
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
      htop emacs git python-setuptools python-dev libatlas-dev libatlas-base-dev liblapack-dev \
      gfortran libatlas3-base build-essential g++ libhdf5-7 libhdf5-dev clang pkg-config libxft2 \
      libffi-dev libssl-dev libxft2-dev build-essential wget ca-certificates git-lfs \
      python3-setuptools python3-dev
RUN easy_install pip
RUN easy_install-3.4 pip
RUN git lfs install

RUN pip3 install cython>=0.21
RUN pip3 install numpy scipy pandas scikit-learn
RUN pip3 install scikit-image
RUN pip3 install keras
RUN pip3 install git+git://github.com/Theano/Theano.git --upgrade --no-deps
RUN pip3 install matplotlib seaborn 
RUN pip3 install jupyter
RUN pip3 install h5py
RUN ipython3 kernel install

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "[global]\nmode=FAST_RUN\ndevice=gpu\nfloatX=float32\n" > .theanorc

RUN apt-get install -y imagemagick

ENV THEANO_FLAGS mode=FAST_RUN,device=gpu,floatX=float32
EXPOSE 8888
WORKDIR /home/ubuntu
CMD jupyter notebook --no-browser --ip=0.0.0.0
