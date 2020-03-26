FROM fedora

MAINTAINER Maciej Szulik <soltysh@gmail.com>

ENV HOME=/opt/home

RUN dnf upgrade -y --setopt=tsflags=nodocs && \
    dnf install -y --setopt=tsflags=nodocs gcc python3-devel redhat-rpm-config ImageMagick && \
    dnf clean all -y && \
    pip3 install --upgrade pip && \
    mkdir -p $HOME && \
    useradd -u 1001 -r -g 0 -d $HOME -s /sbin/nologin -c "Default Application User" default

COPY run.py $HOME/run.py

RUN chown -R 1001:0 $HOME

USER 1001

RUN pyvenv $HOME/.venv && \
    source $HOME/.venv/bin/activate && \
    pip install numpy moviepy

ENTRYPOINT source $HOME/.venv/bin/activate && python $HOME/run.py
