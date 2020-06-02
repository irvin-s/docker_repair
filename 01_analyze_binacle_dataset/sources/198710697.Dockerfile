FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive \
    texlive-latex-extra \
    texlive-fonts-extra \
    pdftk \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/whitepaper

VOLUME /usr/src/whitepaper
WORKDIR /usr/src/whitepaper
