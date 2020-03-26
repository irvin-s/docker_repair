FROM ubuntu:bionic
LABEL maintainer="Socrata 'sysadmin@socrata.com'"

# Default to basic no_proxy list for things that respect it such as set_ark_*
ENV no_proxy localhost,127.0.0.1,169.254.169.254,jenkins
ENV DEBIAN_FRONTEND noninteractive
ENV METRICS_ROOT_DIR /data/metrics

# Add a user so containers can run things as non root.  Not perfect since it is shared across containers,
# but eventually uid namespacing will hopefully fix that.
RUN groupadd -r socrata && useradd -r -g socrata socrata
RUN groupadd -g 31415 metrics && usermod -a -G metrics socrata

RUN apt-get -y update && \
    apt-get -y upgrade; \
    apt-get -y install \
          build-essential \
          locales \
          curl \
          dnsutils \
          python-jinja2 \
          zip \
          ruby2.5
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/pre-init.d

RUN gem2.5 install aws-sdk-resources --pre

COPY env_parse set_ark_host set_ark_hostname set_metrics_dir set_local_dev_hostname ship /bin/
COPY ship.d /etc/ship.d/

# Credential management bits
COPY clortho-get /etc/pre-init.d/clortho-get

#Create Data Directory
ENTRYPOINT ["/bin/ship"]
CMD ["run"]

# Ensure that containers and apps default to UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/base-bionic=""
