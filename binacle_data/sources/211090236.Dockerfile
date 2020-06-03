FROM alpine:latest

COPY test-sample.tex /tmp/test-sample.tex

RUN apk add -U make

# dependencies for texlive
RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/main \
    poppler harfbuzz-icu

# zziplib (found in edge/community repository) is a dependency to texlive-luatex
RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/community \
    zziplib

RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/testing \
    texlive-full

RUN ln -s /usr/bin/mktexlsr /usr/bin/mktexlsr.pl
