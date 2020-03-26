FROM alpine:3.5
MAINTAINER dwhitena

# Jovyan user
ENV NB_USER jovyan 
ENV NB_UID 1000
RUN adduser -s /bin/bash -u $NB_UID -D $NB_USER
USER jovyan
RUN mkdir /home/$NB_USER/work && \
    mkdir /home/$NB_USER/.jupyter && \
    mkdir /home/$NB_USER/.local

USER root

# Install Jupyter.
RUN set -x \
    # install python and dependencies
    && apk update \
    && apk --no-cache add \
        ca-certificates \
        python3 \
        su-exec \
        gcc \
        git \
        py3-zmq \
        pkgconfig \
        zeromq-dev \
        musl-dev \
    && pip3 install --upgrade pip \
    && ln -s /usr/bin/python3.5 /usr/bin/python \
    ## install Go
    && apk --update-cache --allow-untrusted \
        --repository http://dl-4.alpinelinux.org/alpine/edge/community \
        --arch=x86_64 add \
        go \
    ## jupyter notebook
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip3 install jupyter notebook \
    ## clean
    && find /usr/lib/python3.5 -name __pycache__ | xargs rm -r \
    && rm -rf \
        /root/.[acpw]* \
        ipaexg00301* \
    && rm -rf /var/cache/apk/*

USER jovyan

# Install gophernotes and dependencies.
RUN set -x \
    && GOPATH=~/go go get github.com/gopherdata/gophernotes \
    && mkdir -p ~/.local/share/jupyter/kernels/gophernotes \
    && cp -r ~/go/src/github.com/gopherdata/gophernotes/kernel/* ~/.local/share/jupyter/kernels/gophernotes \
    && go get github.com/garyburd/go-oauth/oauth \
    && go get github.com/machinebox/sdk-go/textbox 

USER root
RUN cp /home/jovyan/go/bin/gophernotes /usr/local/bin/
USER jovyan

# Set GOPATH.
ENV GOPATH /home/jovyan/go

# Add Notebooks
ADD . /home/jovyan/notebooks/
WORKDIR /home/jovyan/notebooks
USER root
RUN chown -R jovyan: /home/jovyan/notebooks
USER jovyan

EXPOSE 8888
CMD jupyter notebook --no-browser --port 8888 --ip=* --NotebookApp.token='' --NotebookApp.disable_check_xsrf=True 
