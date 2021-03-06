FROM biocontainers/biocontainers:debian-stretch-backports_cv2
MAINTAINER biocontainers <biodocker@gmail.com>
LABEL    software="fast5" \ 
    base_image="biocontainers/biocontainers:debian-stretch-backports_cv2" \ 
    container="fast5" \ 
    about.summary="utilities for manipulating Oxford Nanopore Fast5 files" \ 
    about.home="https://github.com/mateidavid/fast5" \ 
    software.version="0.6.5-1bpo91-deb" \ 
    upstream.version="0.6.5" \ 
    version="1" \ 
    about.copyright="" \ 
    about.license="MIT" \ 
    about.license_file="/usr/share/doc/fast5/copyright" \ 
    extra.binaries="/usr/bin/f5ls,/usr/bin/f5pack" \ 
    about.tags=""

USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -t stretch-backports -y fast5 && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*
USER biodocker
