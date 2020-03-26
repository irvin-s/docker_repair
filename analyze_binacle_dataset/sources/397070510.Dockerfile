
FROM ubuntu:14.04.2
MAINTAINER Øyvind Skaar (@oyvindsk)

# Dockerfile to clone the latest version of the go book and build the pdf
# Learning Go: http://github.com/miekg/gobook 

# This takes a while and downloads quite a lot of dependencies.. you might want to grap the docker image from the hub instead: 
# https://registry.hub.docker.com/u/oyvindsk/gobook-build-pdf/

# Dependencies taken from http://github.com/miekg/gobook 
# Missing in this version of Ubuntu: (?)
#   ttf-droid           , replaced by fonts-droid#
#   ttf-sazanami-gothic , replaced by fonts-vlgothic (?)
#   ttf-arphic-ukai     , replaced by: fonts-arphic-ukai
#   latex-cjk-xcjk

RUN apt-get update \
    && apt-get install -y -q \
        inkscape \
        gnumeric \
        fonts-droid \
        ttf-dejavu \
        fonts-vlgothic \
        fonts-arphic-ukai \
        texlive-fonts-recommended \
        texlive-extra-utils \
        texlive-xetex \
        texlive-latex-extra \
        texlive-latex-recommended \
        git-core \
        make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

ADD get-and-build.sh ./
RUN chmod +x /root/get-and-build.sh
CMD /root/get-and-build.sh


