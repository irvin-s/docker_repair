##
## hepsw/lhcb-gaudi
## A container where the GAUDI software stack has been installed
##
FROM hepsw/lhcb-base
MAINTAINER Sebastien Binet "binet@cern.ch"

USER root

ENV MYSITEROOT /opt/lhcb-sw
ENV PATH       $MYSITEROOT/usr/bin:$PATH
ENV CMTCONFIG x86_64-slc6-gcc48-opt

## install (source+binaries) and clean-up
RUN lbpkr install-project GAUDI v26r1 && \
    /bin/rm -rf $MYSITEROOT/{tmp,targz} && \
    /bin/mkdir $MYSITEROOT/{tmp,targz}

## switch to 'lhcb' user
USER lhcb
ENV USER lhcb
ENV HOME /home/$USER

WORKDIR $HOME/run

## make the whole container seamlessly executable
ENTRYPOINT ["/bin/bash"]

## EOF

