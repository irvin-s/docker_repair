# Dockerfile for running jepsen tests
#

FROM stackbrew/ubuntu:saucy
MAINTAINER arnaud@capital-match.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y git

# get locale right
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# The following 
# Install Oracle Java 8
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common python-software-properties && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update -q && \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer && \
  apt-get clean

# Install Clojure 1.6
RUN \
  mkdir -p /usr/share/clojure/bin && \
  mkdir -p /usr/share/clojure/lib && \
  wget -O /usr/share/clojure/lib/clojure-1.6.0.jar http://central.maven.org/maven2/org/clojure/clojure/1.6.0/clojure-1.6.0.jar

RUN \
  echo "#!/bin/sh" > /usr/share/clojure/bin/clojure \
  echo "exec java -cp /usr/share/clojure/lib/clojure-1.6.0.jar clojure.main" >> /usr/share/clojure/bin/clojure \
  chmod +x /usr/share/clojure/bin/clojure && \
  ln -s /usr/share/clojure/bin/clojure /usr/bin/clojure

# Install leiningen
RUN \
  mkdir -p /usr/share/leiningen &&\
  wget -O /usr/share/leiningen/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
  chmod +x /usr/share/leiningen/lein && \
  ln -s /usr/share/leiningen/lein /usr/bin/lein && \
  lein

# clone jepsen repo
RUN git clone https://github.com/abailly/jepsen.git

WORKDIR jepsen

ENV LEIN_ROOT true
# Compile jepsen
RUN lein deps &&\
    lein compile

CMD ["/bin/bash"] 
