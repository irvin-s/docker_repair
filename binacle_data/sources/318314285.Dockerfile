FROM nvidia/cuda:9.0-base
#FROM nvidia/cuda:9.1-base
#FROM nvidia/cuda:9.2-devel-ubuntu18.04
#FROM nvidia/cuda:9.0-devel-ubuntu18.04
MAINTAINER Tom Breuel <tmbdev@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get -y update && apt-get dist-upgrade -y

RUN  apt-get -y install sudo lsb-release build-essential curl software-properties-common \
    && echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" \
           >> /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update -y && apt-get dist-upgrade -y && apt-get -y install apt-utils

RUN apt-get -y install locales && locale-gen en_US.UTF-8 && dpkg-reconfigure locales \
    && apt-get -y install google-cloud-sdk

RUN apt-get -y install wget tightvncserver tmux rxvt \
    xterm mlterm imagemagick firefox blackbox imagemagick \
    vim-gtk gnome-terminal i3 chromium-browser git mercurial lynx daemon

RUN apt-get install -y nginx
RUN apt-get install -y nginx-extras
RUN apt-get install -y cadaver

RUN cd /tmp \
    && wget --quiet -nd https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh \
    && bash ./Miniconda2-latest-Linux-x86_64.sh -b -p /opt/conda \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && ln -s /opt/conda/bin/conda /usr/bin/conda \
    && rm -f Miniconda*.sh

RUN apt-get install -y redis-tools

RUN conda install git
RUN conda install numpy
RUN conda install scipy
RUN conda install msgpack
RUN conda install simplejson
RUN conda install pyzmq
RUN conda install jupyter
RUN conda install scikit-image
RUN conda install scikit-learn
RUN conda install redis
RUN conda install Pillow
RUN conda install pytorch=0.3.1 torchvision cuda90 -c pytorch
RUN conda install msgpack
RUN conda install -c conda-forge google-cloud-storage
RUN conda install cython
RUN conda install -c auto editdistance

RUN conda install -c menpo opencv3
RUN conda install pip && ln -s /opt/conda/bin/pip /usr/bin/pip
RUN conda install setuptools

ENV PATH /opt/conda/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY dlinputs /tmp/dlinputs
RUN cd /tmp/dlinputs && python setup.py install && rm -rf /tmp/dlinputs
COPY dltrainers /tmp/dltrainers
RUN cd /tmp/dltrainers && python setup.py install && rm -rf /tmp/dltrainers
COPY dlmodels /tmp/dlmodels
RUN cd /tmp/dlmodels && python setup.py install && rm -rf /tmp/dlmodels
COPY cctc /tmp/cctc
RUN cd /tmp/cctc && python setup.py install && rm -rf /tmp/cctc
COPY ocrobin /tmp/ocrobin
RUN cd /tmp/ocrobin && python setup.py install && rm -rf /tmp/ocrobin
COPY ocrodeg /tmp/ocrodeg
RUN cd /tmp/ocrodeg && python setup.py install && rm -rf /tmp/ocrodeg
COPY ocroline /tmp/ocroline
RUN cd /tmp/ocroline && python setup.py install && rm -rf /tmp/ocroline
COPY ocrorot /tmp/ocrorot
RUN cd /tmp/ocrorot && python setup.py install && rm -rf /tmp/ocrorot
COPY ocroseg /tmp/ocroseg
RUN cd /tmp/ocroseg && python setup.py install && rm -rf /tmp/ocroseg

ENV USER user
ENV HOME /home/$USER
ENV GID 1000
ENV UID 1000

ENV TERM xterm
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

COPY nginx.conf /etc/nginx
EXPOSE 3218

RUN mkdir -p $HOME && groupadd -g $GID -r $USER && useradd --no-log-init -u $UID -r -g $USER $USER

RUN mkdir -p $HOME/.jupyter $HOME/.vnc $HOME/.ssh
ADD jupyter_config/* $HOME/.jupyter/
ADD vnc_config/* $HOME/.vnc/
ADD scripts/* /usr/local/bin/

RUN true \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> $HOME/.bashrc \
    && echo "conda activate base" >> $HOME/.bashrc \
    && chown -R $USER.$USER $HOME
RUN echo 'user ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

USER $UID
ENTRYPOINT ["runcmd"]
