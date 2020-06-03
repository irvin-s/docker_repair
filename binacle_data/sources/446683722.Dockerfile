# References:
# https://docs.docker.com/engine/reference/builder/

FROM ubuntu:artful

#############
#  apt-get  #
#############
# Install openssh-server and set up server keys first to minimize the chance to invalidate
# the cache and regenerate server keys.
RUN apt-get update && apt-get install -y openssh-server && rm -rf /var/lib/apt/lists/*

# Install other apt-packages.
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run
# software-properties-common is required for add-apt-repository.
RUN apt-get update && apt-get install -y\
  zip unzip curl wget screen emacs git zsh rsyslog\
  python python-pip gcc clang openjdk-8-jdk rustc \
  apt-transport-https ca-certificates curl software-properties-common lsb-release \
  libzmq3-dev \
  && rm -rf /var/lib/apt/lists/*

# https://github.com/golang/go/wiki/Ubuntu
RUN add-apt-repository ppa:gophers/archive && apt update && apt-get install golang-1.9-go -y && rm -rf /var/lib/apt/lists/*

# Install Python ML libraries.
# Note: Use scikit-learn, not sklearn.
RUN pip install --upgrade pip && pip install -U numpy scipy matplotlib pandas scikit-learn jupyter tensorflow

# Install docker-ce for ubuntu
# https://docs.docker.com/engine/installation/linux/ubuntu/
# As of 2017-12, we need to use edge channel to install Docker in ubuntu:artful.
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - &&\
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) edge" &&\
  apt-get update && apt-get install -y docker-ce && rm -rf /var/lib/apt/lists/*

# Install gcloud (https://cloud.google.com/sdk/downloads#apt-get)
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && apt-get update && apt-get install -y google-cloud-sdk && rm -rf /var/lib/apt/lists/*

# https://docs.docker.com/engine/reference/builder/#arg
# Do not move this to the head of Dockerfile because
# the definition of ARG causes cache-miss in following RUN commands
# regardless of whether they refer an arg or not.
ARG user=yunabe

# The guidline recommends us to execute commands in non-root.
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#user
#
# You should not change the owner of the home dir or set USER before COPY operations
# because COPY ignores USER (https://github.com/docker/docker/issues/6119).
RUN groupadd -r developer && useradd -r -g developer $user
RUN chsh -s /bin/zsh $user
RUN mkdir -p /home/$user
WORKDIR /home/$user

# Allow the user to run docker.
# See https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
RUN gpasswd -a $user docker

# Set up .ssh keys
COPY _ssh .ssh
RUN chmod 700 .ssh

# Copy dot files in local_config then remove local_config/README.md.
COPY local_config/* ./
RUN rm README.md
COPY Cask ./.emacs.d/Cask

# Finally, change the owner of the home dir and set USER.
RUN chown -R $user:developer /home/$user
USER $user

# Set up public dot files as $user.
RUN git clone git@github.com:yunabe/linux-user-config.git config && ./config/setup.sh
RUN curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
RUN cd .emacs.d && $HOME/.cask/bin/cask install

# Misc as the user
RUN mkdir -p src && cd src && git clone git@github.com:yunabe/codelab.git && git clone git@github.com:yunabe/lgo-binder
RUN mkdir -p local/gocode/src/github.com/yunabe && cd local/gocode/src/github.com/yunabe &&\
  git clone git@github.com:yunabe/gae-codelab.git &&\
  git clone git@github.com:yunabe/lgo &&\
  git clone git@github.com:yunabe/easycsv
RUN go get -u golang.org/x/tools/cmd/gorename github.com/nsf/gocode github.com/nfnt/resize github.com/yunabe/lgo/cmd/lgo &&\
  go get -d github.com/yunabe/lgo/cmd/lgo-internal

USER root
# Add additional setup as root with minimum cache invalidation.

# Apply root_config.patch to rewrite root configurations.
COPY root_config.patch /root_config.patch
RUN cd / && patch -p0 < /root_config.patch && rm -f /root_config.patch

# Run services as root and sleep.
# - ssh: ssh server
# - rsyslog: Record /var/log/auth.log from sshd.
CMD service ssh start && service rsyslog start && service docker start && sleep infinity
