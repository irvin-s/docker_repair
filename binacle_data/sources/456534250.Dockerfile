FROM ubuntu:latest

RUN mkdir -p chromium

WORKDIR /

RUN apt-get update && apt-get install -y git python

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

ENV PATH $PATH:/depot_tools

WORKDIR /chromium

RUN fetch --nohooks chromium

RUN apt-get install -y build-essential lsb-release locales

WORKDIR /chromium/src

RUN mkdir -p /tools
ENV PATH $PATH:/tools
ADD fake_sudo /tools/sudo

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN build/install-build-deps.sh --no-prompt --no-arm --no-chromeos-fonts --no-nacl

RUN gclient runhooks

RUN gn gen out/Default

RUN ninja -C out/Default chromedriver
