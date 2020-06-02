FROM socrata/base-xenial

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv DF7D54CBE56151BF

RUN echo "deb http://repos.mesosphere.com/ubuntu xenial main" > /etc/apt/sources.list.d/mesosphere.list

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install \
    openjdk-8-jre-headless \
    mesos=1.7.2-2.0.1 \
    chronos=2.5.1-0.1.20171211074431.ubuntu1604

# We want to configure everything via env variables and duplicate config is an error
RUN rm -f /etc/chronos/conf/http_port

COPY ship.d /etc/ship.d/
