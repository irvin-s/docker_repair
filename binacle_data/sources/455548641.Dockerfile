FROM ruby:2.4

LABEL Description="Certificate Rotation SPIFFE: Harness"
LABEL vendor="SPIFFE"
LABEL version="0.1.0"



# Set the locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Install basics
RUN apt-get update -y
RUN apt-get install -y \
    tmux \
    emacs \
    git \
    python \
    python-dev \
    python-distribute \
    python-pip \
    curl \
    unzip
RUN rm -rf /var/lib/apt/lists/*

# Map DockerCompose directory for service

# Install docker-compose
# TODO: See if we can mount the binary from the Base OS
RUN pip install docker-compose

# Install Gems
RUN gem install tmuxinator
ENV EDITOR "emacs"

# Inject development configuration
COPY rosemary.yml /root/.tmuxinator/rosemary.yml
COPY .tmux.conf.local  /root/.tmux.conf.local
COPY registration /root/
COPY ghostunnel /root/

WORKDIR /root
RUN git clone https://github.com/gpakosz/.tmux.git
RUN ln -s -f .tmux/.tmux.conf

