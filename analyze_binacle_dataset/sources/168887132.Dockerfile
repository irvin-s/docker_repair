FROM socrata/base

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy install software-properties-common && \
  DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:openjdk-r/ppa && apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install openjdk-8-jdk

# Regenerate certs to work around bug in ca-certificates-java that results in missing Java certs
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=775775
RUN update-ca-certificates -f

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/java8=""
