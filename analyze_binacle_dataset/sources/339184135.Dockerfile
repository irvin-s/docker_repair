FROM debian:stretch

WORKDIR /tidy-cv

ADD Makefile /tidy-cv

RUN apt-get clean \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        biber \
        build-essential \
        ghostscript \
        graphicsmagick \
        texlive \
        texlive-bibtex-extra \
        texlive-fonts-extra \
        texlive-lang-cyrillic \
        texlive-latex-extra

ENTRYPOINT ["make"]
