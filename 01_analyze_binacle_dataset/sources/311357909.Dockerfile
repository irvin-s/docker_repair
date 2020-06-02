FROM ubuntu:bionic

ENV NODE_VERSION 8.11.2
ENV YARN_VERSION 1.7.0
ENV DSPACE_ANGULAR_GIT https://github.com/DSpace/dspace-angular.git
ENV DSPACE7-SPRING-REST https://dspace7.4science.it/dspace-spring-rest/

RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-transport-https \
        build-essential \
        bash-completion \
        ca-certificates \
        curl \
        gcc \
        git \
        gnupg \
        less \
        libkrb5-dev \
        libssl-dev \
        locales \
        make \
        python \
        ruby-full \
        rubygems-integration \
        screen \
        software-properties-common \
        sudo \
        unzip \
        vim \
        wget \
        && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

WORKDIR /tmp

run mkdir -p /root/.gnupg && chmod 700 /root/.gnupg

# gpg keys listed at https://github.com/nodejs/node#release-team
RUN set -ex \
  && for key in \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    56730D5401028683275BD23C23EFEFE93C4CFFFE \
    77984A986EBC2AA786BC0F66B01FBB92821C587A \
  ; do \
    gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
  done

RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    ppc64el) ARCH='ppc64le';; \
    s390x) ARCH='s390x';; \
    arm64) ARCH='arm64';; \
    armhf) ARCH='armv7l';; \
    i386) ARCH='x86';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN set -ex \
  && for key in \
    6A010C5166006599AA17F08146C2130DFD2497F5 \
  ; do \
    gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
  done \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
  && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
  && mkdir -p /opt \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz

#Create DSpace folders
RUN mkdir -p /dspace-angular /home/dspace

###
# Bash configuration
###
#Configure colors and autocompletion
COPY bashrc /home/dspace/.bashrc
# fill the bash history with some commands
COPY bash_history /home/dspace/.bash_history
# Configure other useful dotfiles
COPY screenrc /home/dspace/.screenrc
COPY vimrc /home/dspace/.vimrc
COPY gitconfig /home/dspace/.gitconfig
RUN mkdir /home/dspace/.vimbackup


# create user
RUN export HOME=/home/dspace
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/dspace && \
    echo "dspace:x:${uid}:${gid}:DSpace,,,:/home/dspace:/bin/bash" >> /etc/passwd && \
    echo "dspace:x:${uid}:" >> /etc/group && \
    echo "dspace ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dspace && \
    chmod 0440 /etc/sudoers.d/dspace && \
    chown ${uid}:${gid} -R /home/dspace

# Fix permissions
RUN chown -R dspace:dspace /dspace-angular /home/dspace

# Change the current user
USER dspace

# preload node_modules
RUN git clone ${DSPACE_ANGULAR_GIT} /tmp/dspace-angular \
      && cd /tmp/dspace-angular \
      && yarn install \
      && cd - \
      && rm -rf /tmp/dspace-angular

WORKDIR /dspace-angular

# 3000 for node
# 8080 to test if changing the port by an environment variable works
# 9876 to see test coverage
EXPOSE 3000 8080 9876

CMD tail -f /dev/null
