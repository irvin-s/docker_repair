#################################################################
# Dockerfile that can be used to build the pdf from latex sources
# Based on Ubuntu:14.04
# Build with:
#
#     docker build -t username/sympy-paper:v1 .
#
# Run with:
#
#     docker run -it -v `pwd`:/home/swuser/data username/sympy-paper:v1
#
# This mounts your current directory (i.e., this repository) into ~/data in the
# countainer, logs you in as a swuser and runs bash. Inside the container,
# build the paper using:
#
#     cd data
#     make
#
# Note: in order to have the correct permissions when you mount your host
# directory, you might want to change below the uid and git from 1000 to your
# user uid and git (which you can find out by executing 'id').
#################################################################

FROM ubuntu:14.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq --no-install-recommends \
        texlive-fonts-recommended texlive-latex-extra texlive-fonts-extra \
        texlive-humanities texlive-science latex-xcolor dvipng \
        texlive-latex-recommended python-pygments \
        lmodern texlive-xetex \
        make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && hash -r

RUN groupadd -r swuser -g 1000 && \
    mkdir /home/swuser && \
    useradd -u 1000 -r -g swuser -d /home/swuser -s /sbin/nologin \
         -c "Docker image user" swuser && \
    chown -R swuser:swuser /home/swuser
WORKDIR /home/swuser

USER swuser

VOLUME ["/home/swuser/data"]
