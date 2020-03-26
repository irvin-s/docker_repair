FROM pitkley/jenkins-swarm-slave
MAINTAINER Pit Kleyersburg <pitkley@googlemail.com>

USER root

# Install python 2.6.9
ENV PYTHON_VERSION 2.6.9
ENV PYENV_ROOT /pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

ENV PYENV_REF tags/v20160629

ENV BUILD_PACKAGES build-essential libreadline-dev zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev
RUN apt-get update \
    && apt-get install -y --no-install-recommends $BUILD_PACKAGES \
    && git clone https://github.com/yyuu/pyenv.git $PYENV_ROOT \
    && (cd $PYENV_ROOT && git checkout -q $PYENV_REF) \
    && pyenv install $PYTHON_VERSION \
    && pyenv global $PYTHON_VERSION \
    && chown -R jenkins-slave:jenkins-slave $PYENV_ROOT \
    && apt-get purge -y $BUILD_PACKAGES \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Allow all ssh-hosts (for git-cloning)
RUN sed -i "s/^#\(.*\)StrictHostKeyChecking.*$/\1StrictHostKeyChecking no/g" /etc/ssh/ssh_config

USER jenkins-slave
ENV PATH $PYENV_ROOT/shims:$PATH
