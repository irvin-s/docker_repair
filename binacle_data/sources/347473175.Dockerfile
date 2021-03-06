# Create a Docker image that is ready to run the main Checker Framework tests,
# using JDK 8.

FROM ubuntu
MAINTAINER Michael Ernst <mernst@cs.washington.edu>

# According to
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/:
#  * Put "apt-get update" and "apt-get install" in the same RUN command.
#  * Do not run "apt-get upgrade"; instead get upstream to update.
RUN apt-get -qqy update && apt-get -qqy install \
  ant \
  cpp \
  git \
  gradle \
  libcurl3-gnutls \
  make \
  maven \
  mercurial \
  unzip \
  wget \
  default-jdk \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
