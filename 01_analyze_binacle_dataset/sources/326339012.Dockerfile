FROM asgpu/notebook:tf-1.10-9d4973b6
LABEL maintainer=afun@afun.tw
SHELL ["/bin/bash", "-c"]

# Set locale
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# root env
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl htop python-dev python3-dev apt-utils pkgconf \
        python2.7 python-setuptools python-pip git vim && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# user env
USER $NB_UID
ENV PATH=$PATH:~/.local/bin
RUN pip install pipenv