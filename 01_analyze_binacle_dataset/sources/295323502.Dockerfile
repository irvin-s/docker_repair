FROM steinwaywhw/ats-base
MAINTAINER Steinway Wu "https://github.com/steinwaywhw"

ARG ATSVER 

ENV CC=gcc
ENV HOME=/root

ENV ATSVER=$ATSVER
ENV ATSHOME=${HOME}/ats-lang-anairiats-${ATSVER}
ENV ATSHOMERELOC=ATS-${ATSVER}

ENV PATSHOME=${HOME}/ATS-Postiats
ENV PATSCONTRIB=${HOME}/ATS-Postiats-contrib
ENV PATSHOME_contrib=${HOME}/ATS-Postiats-contrib

ENV PATH=${PATH}:${PATSHOME}/bin

WORKDIR ${HOME}
RUN git clone https://github.com/ats-lang/ATS-Postiats-release/ ${HOME}/ATS-Postiats

RUN (cd ${HOME}     && sh ${PATSHOME}/my-travis-ci/install_ats1.sh)
RUN (cd ${PATSHOME} && sh ${PATSHOME}/my-travis-ci/install_ats2.sh)
RUN (cd ${PATSHOME} && sh ${PATSHOME}/my-travis-ci/install_contrib.sh)
RUN (cd ${PATSHOME} && sh ${PATSHOME}/my-travis-ci/install_utilities.sh)

CMD patscc -vats
