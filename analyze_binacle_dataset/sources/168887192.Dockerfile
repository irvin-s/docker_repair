FROM socrata/runit

# Set up environment
ENV LANG C.UTF-8

# Add erlang solutions repo
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install wget && \
    wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i erlang-solutions_1.0_all.deb

# Install erlang & elixir
# NOTE: esl-erlang & elixir are pinned to specific versions
# Any changes to these versions should be synchronized in the
# jenkins-workers cookbook and a new AMI should be built.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install esl-erlang=1:21.0 elixir=1.6.6-1

# Install Java 8. If we start using this image for things other than one app, we might want to revisit this.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy install software-properties-common && \
  DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:openjdk-r/ppa && apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install openjdk-8-jdk

# Regenerate certs to work around bug in ca-certificates-java that results in missing Java certs
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=775775
RUN update-ca-certificates -f

# Add collectd config file
COPY collectd-socket.conf /etc/collectd/conf.d/socket.conf

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/runit-elixir=""
