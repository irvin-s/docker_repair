# Docker image for building Android APKs via buildozer
# Build with:
# docker build --tag=etheroll-android --file=dockerfiles/Dockerfile-android .
# Run with:
# docker run etheroll-android /bin/sh -c 'buildozer android debug'
# Or using the entry point shortcut:
# docker run etheroll-android 'buildozer android debug'
# Or for interactive shell:
# docker run -it --rm etheroll-android
FROM ubuntu:18.04

ARG TRAVIS=false
ENV USER="user"
ENV HOME_DIR="/home/${USER}"
ENV WORK_DIR="${HOME_DIR}" \
    PATH="${HOME_DIR}/.local/bin:${PATH}"
ENV DOCKERFILES_VERSION="master" \
    DOCKERFILES_URL="https://raw.githubusercontent.com/AndreMiras/dockerfiles"
ENV MAKEFILES_URL="${DOCKERFILES_URL}/${DOCKERFILES_VERSION}/buildozer_android_new"


# configure locale
RUN apt update -qq > /dev/null && apt install -qq --yes --no-install-recommends \
    locales && \
    locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

# install system dependencies (required to setup all the tools)
RUN apt install -qq --yes --no-install-recommends \
    make curl ca-certificates xz-utils unzip openjdk-8-jdk sudo python-pip \
    python-setuptools

# install build dependencies (required to successfully build the project)
# TODO: should this go to a Makefile instead so it can be shared/reused?
RUN apt install -qq --yes --no-install-recommends \
    python3.6 libpython3.6-dev python3-setuptools \
    autoconf automake libtool libltdl-dev libffi-dev bsdtar zip

# prepare non root env
RUN useradd --create-home --shell /bin/bash ${USER}
# with sudo access and no password
RUN usermod -append --groups sudo ${USER}
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ${USER}
WORKDIR ${WORK_DIR}

# install buildozer and dependencies
RUN curl --location --progress-bar ${MAKEFILES_URL}/buildozer.mk --output buildozer.mk
RUN make -f buildozer.mk
# enforces buildozer master (586152c) until next release
RUN pip install --upgrade https://github.com/kivy/buildozer/archive/586152c.zip

COPY . ${WORK_DIR}
# limits the amount of logs for Travis
RUN if [ "${TRAVIS}" = "true" ]; then sed 's/log_level = [0-9]/log_level = 1/' -i buildozer.spec; fi
ENTRYPOINT ["./dockerfiles/start.sh"]
