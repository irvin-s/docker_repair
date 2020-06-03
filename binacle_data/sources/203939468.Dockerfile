FROM ubuntu:16.04
MAINTAINER Vincent Llorens <vincent.llorens@cc.in2p3.fr>
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository cloud-archive:newton
RUN apt-get update \
    && apt-get install -y build-essential \
                          debhelper \
                          devscripts \
                          dh-systemd \
                          git-core \
                          python-all \
                          python-pbr \
                          python-setuptools
RUN mkdir /tmp/synergy
RUN useradd -m -p pkger pkger
USER pkger
COPY build.sh /home/pkger/build.sh
WORKDIR /home/pkger
CMD bash build.sh
