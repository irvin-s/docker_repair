FROM ubuntu:trusty

MAINTAINER https://github.com/emichael/SlackLaTeXBot


# Install main dependencies first
RUN apt-get update && \
    apt-get install -y \
      python-pip \
      texlive \
      texlive-extra-utils \
      ImageMagick


# Verify and add Tini
ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys \
      595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
    gpg --verify /tini.asc
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]


# Install app
COPY LatexServer.py error.png requirements.txt /
RUN pip install -r requirements.txt
RUN mkdir images


# Don't run as root
RUN adduser --system --shell /bin/bash --uid 724 --group \
      --no-create-home --disabled-password --disabled-login slacklatex  && \
    chown -R slacklatex:slacklatex LatexServer.py error.png requirements.txt images
USER slacklatex


# Setup app
EXPOSE 8642/tcp
ENTRYPOINT ["/tini", "--", "python", "/LatexServer.py"]
