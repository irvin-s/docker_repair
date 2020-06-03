FROM       centos:7
MAINTAINER Alex Banna alexb@tune.com
ENV        REFRESHED_AT 2016-1-22

# Define python verisons.
ENV PYTHON2 "2.7.10"
ENV PYTHON3 "3.4.3"
ENV APP_NAME freight_forwarder
ENV HOME /opt/$APP_NAME

# install system packages
RUN yum -y update && \
    yum -y install gcc make curl patch zlib-devel bzip2 bzip2-devel git \
        readline-devel sqlite sqlite-devel openssl-devel tar && \
    yum -y clean all && \
    mkdir -p $HOME

# change to root home
WORKDIR $HOME

# add source code
ADD ./ $HOME

# install pyenv
RUN curl -kL https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

# set pyenv variables
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# install python versions
RUN pyenv install $PYTHON2 && \
    pyenv install $PYTHON3 && \
    pyenv global $PYTHON2 $PYTHON3 && \
    pyenv rehash

# upgrade pip, install packages, and create freight forwarder package.
RUN pip install --upgrade pip && \
    pip2 install --upgrade pip && \
    pip2 install wheel setuptools && \
    pip2 install -r requirements.txt && \
    python2 setup.py bdist_wheel && \
    pip3 install --upgrade pip && \
    pip3 install wheel setuptools && \
    pip3 install -r requirements.txt && \
    python3 setup.py bdist_wheel && \
    pip install $HOME

# share the wheel with other containers.
VOLUME ["dist"]

ENTRYPOINT ["freight-forwarder"]
