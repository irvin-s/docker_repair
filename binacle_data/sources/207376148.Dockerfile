FROM ubuntu:xenial
MAINTAINER Michael Parks <mparks@tkware.info>

RUN apt-get update && apt-get install --no-install-recommends -y \
python \
python-pip \
git \
mercurial \
&& pip install requests \
&& rm -rf /var/lib/apt/lists/*

ADD scripts/ /opt/resource/
