FROM ubuntu:trusty

#Default branch name develop
ARG BRANCH_NAME=develop
#Default
ARG REPO_SLUG=bitcoinair/bitcoinair
ENV REPO_SLUG=${REPO_SLUG}
ENV REPO_URL=https://github.com/${REPO_SLUG}

RUN apt-get -qq update && \
    apt-get -qqy install \
    git \
    sudo

#RUN git clone ${REPO_URL} --branch $BRANCH_NAME --single-branch --depth 1

COPY bitcoinair.tar.gz /bitcoinair.tar.gz
RUN tar -xvf /bitcoinair.tar.gz

#xenial
#Missing requirement: libtool
#RUN apt install -yqq libtool-bin
RUN cd /bitcoinair/scripts/windows-crosscompile && ./dependencies.sh
RUN cd /bitcoinair && scripts/windows-crosscompile/compile-bitcoinair.sh
