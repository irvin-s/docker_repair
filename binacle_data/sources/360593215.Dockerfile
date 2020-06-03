FROM debian:jessie

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

WORKDIR /borg

ENTRYPOINT ["/usr/bin/borgctl"]
CMD ["--help"]

# to prevent some filepath issues with python code we have to set the language
ENV LANG C.UTF-8
RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y \
        build-essential \
        fuse \
        git-core \
        libacl1-dev \
        libfuse-dev \
        liblz4-dev \
        liblzma-dev \
        libssl-dev \
        openssh-server \
        pkg-config \
        python-lz4 \
        python-virtualenv \
        python3-dev \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ADD misc/shini/shini.sh /usr/bin/shini

RUN virtualenv --python=python3 /borg/env ; \
    . /borg/env/bin/activate ; \
    pip -v --log=/borg/pip-install.log install --upgrade pip ; \
    pip -v --log=/borg/pip-install.log install cython ; \
    pip -v --log=/borg/pip-install.log install tox

ARG IMAGE_VERSION
ENV IMAGE_VERSION ${IMAGE_VERSION:-1.0.11}
RUN git clone https://github.com/borgbackup/borg.git ./borgbackup-git -b ${IMAGE_VERSION}; \
    . /borg/env/bin/activate ; \
    pip -v --log=/borg/pip-install.log install 'llfuse<0.41' ;\
    pip -v --log=/borg/pip-install.log install -r ./borgbackup-git/requirements.d/development.txt ;\
    pip -v --log=/borg/pip-install.log install -e ./borgbackup-git

ADD misc/borgbackup.ini /borg/example.ini
ADD adds/borgctl /usr/bin/borgctl

RUN chmod a+x /usr/bin/borgctl /usr/bin/shini ;\
    mkdir -p /REPO /BACKUP /RESTORE /STORAGE;\
    rm -rf /etc/ld.so.cache

