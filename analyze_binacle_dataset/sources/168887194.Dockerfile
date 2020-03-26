FROM socrata/runit
MAINTAINER Socrata <sysadmin@socrata.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy install software-properties-common && \
  DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:openjdk-r/ppa && apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install openjdk-8-jdk

# Regenerate certs to work around bug in ca-certificates-java that results in missing Java certs
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=775775
RUN update-ca-certificates -f

ENV LD_LIBRARY_PATH /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:${LD_LIBRARY_PATH}
ENV JAVA_TOOL_OPTIONS="-Dcom.sun.management.jmxremote.port=11114 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

COPY set_jmx_hostname /etc/my_init.d/set_jmx_hostname
COPY collectd-jmx.conf /etc/collectd/conf.d/jmx.conf

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/runit-java8=""
