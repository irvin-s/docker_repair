# Docker image for installing dependencies on Linux and running tests.
# Build with:
# docker build --tag=etheroll-linux --file=dockerfiles/Dockerfile-linux .
# Run with:
# docker run etheroll-linux /bin/sh -c 'make test'
# Or using the entry point shortcut:
# docker run etheroll-linux 'make test'
# Or for interactive shell:
# docker run -it --rm etheroll-linux
# For running UI:
# xhost +"local:docker@"
# docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix etheroll-linux 'make uitest'
FROM ubuntu:18.04

ENV USER="user"
ENV HOME_DIR="/home/${USER}"
ENV WORK_DIR="${HOME_DIR}"

# configure locale
RUN apt update -qq > /dev/null && apt install --yes --no-install-recommends \
    locales && \
    locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

# install system dependencies
RUN apt install --yes --no-install-recommends \
    build-essential \
    git \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    libssl-dev \
    lsb-release \
    make \
    pkg-config \
	python3 \
    python3-dev \
    sudo \
    tox \
    virtualenv

# prepare non root env
RUN useradd --create-home --shell /bin/bash ${USER}
# with sudo access and no password
RUN usermod -append --groups sudo ${USER}
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ${USER}
WORKDIR ${WORK_DIR}
COPY . ${WORK_DIR}

RUN sudo make system_dependencies
# required by Kivy `App.user_data_dir`
RUN mkdir ~/.config
ENTRYPOINT ["./dockerfiles/start.sh"]
