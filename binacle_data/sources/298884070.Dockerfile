FROM ubuntu:xenial as base

RUN apt-get update && apt-get -y install \
    sudo \
    curl \
    locales \
    && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Add fixuid to change permissions for bind-mounts. Set uid to same as host with -u <uid>:<guid>
RUN addgroup --gid 1000 docker && \
    adduser --uid 1000 --ingroup docker --home /home/docker --shell /bin/sh --disabled-password --gecos "" docker && \
    usermod -aG sudo docker && \
    sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers
RUN USER=docker && \
    GROUP=docker && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.3/fixuid-0.3-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\npaths:\n  - /service\n" > /etc/fixuid/config.yml

RUN echo "LANG=C.UTF-8" > /etc/default/locale

# TAG can be specified when building with --build-arg TAG=..., this is redeclared in the source-build stage
ARG BRANCH=dev
ARG REPO=hioa-cs
ENV BRANCH=$BRANCH
ENV REPO=$REPO

LABEL dockerfile.version=1 \
      includeos.version=$BRANCH
WORKDIR /service

#########################
FROM base as source-build

RUN apt-get update && apt-get -y install \
    git \
    lsb-release \
    net-tools \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Triggers new build if there are changes to head
#ADD https://api.github.com/repos/$REPO/IncludeOS/git/refs/heads/$BRANCH version.json

RUN echo "cloning $BRANCH"

RUN cd ~ && pwd && \
  git clone https://github.com/$REPO/IncludeOS.git && \
  cd IncludeOS && \
  git checkout $BRANCH && \
  git submodule update --init --recursive && \
  git fetch --tags

RUN cd ~ && pwd && \
  cd IncludeOS && \
  ./install.sh -n

RUN git -C /root/IncludeOS describe --tags > /ios_version.txt

###########################
FROM base as build

RUN apt-get update && apt-get -y install \
    git \
    clang-5.0 \
    cmake \
    nasm \
    python-pip \
    && rm -rf /var/lib/apt/lists/* \
    && pip install pystache antlr4-python2-runtime && \
    apt-get remove -y python-pip && \
    apt autoremove -y

COPY --from=source-build  /usr/local/includeos /usr/local/includeos/
COPY --from=source-build  /usr/local/bin/boot /usr/local/bin/boot
COPY --from=source-build  /root/IncludeOS/etc/install_dependencies_linux.sh /
COPY --from=source-build  /root/IncludeOS/etc/use_clang_version.sh /
COPY --from=source-build  /root/IncludeOS/lib/uplink/starbase /root/IncludeOS/lib/uplink/starbase/
COPY --from=source-build  /ios_version.txt /
COPY  entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD mkdir -p build && \
  cd build && \
  cp $(find /usr/local/includeos -name chainloader) /service/build/chainloader && \
  cmake .. && \
  make

#############################
FROM base as grubify

RUN apt-get update && apt-get -y install \
  dosfstools \
  grub-pc

COPY --from=source-build /usr/local/includeos/scripts/grubify.sh /home/ubuntu/IncludeOS_install/includeos/scripts/grubify.sh

ENTRYPOINT ["fixuid", "/home/ubuntu/IncludeOS_install/includeos/scripts/grubify.sh"]

###############################
FROM build as webserver

RUN apt-get update && apt-get -y install git \
    && rm -rf /var/lib/apt/lists/*

COPY --from=source-build /root/IncludeOS/examples/acorn /acorn

WORKDIR /acorn

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD mkdir build && cd build && \
  rm -rf /acorn/disk1/public/* && \
  cp -a -v /public/. /acorn/disk1/public && \
  cmake .. && \
  make && \
  cp acorn /public
