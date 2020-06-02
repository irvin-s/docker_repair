##
## hepsw/lhcb-base
## A container where the means to install the LHCb software stack have been installed
##
FROM hepsw/slc-base
MAINTAINER Sebastien Binet "binet@cern.ch"

USER root

ENV MYSITEROOT /opt/lhcb-sw
ENV PATH       $MYSITEROOT/usr/bin:$PATH
ENV CMTCONFIG x86_64-slc6-gcc48-opt

RUN mkdir -p $MYSITEROOT

## install some system dependencies
RUN yum install -y \
    bzip2 \
    csh \
    freetype \
    glibc-headers \
    sudo \
    tar \
    time \
    which \
    ; \
    yum clean all

## retrieve install
RUN curl -O -L http://cern.ch/lhcbproject/dist/rpm/lbpkr && \
    chmod +x ./lbpkr && \
    ./lbpkr install lbpkr && \
    /bin/rm ./lbpkr && \
    lbpkr version

## install LBSCRIPTS (for LbLogin) and clean-up
RUN lbpkr install LBSCRIPTS && \
    /bin/rm -rf $MYSITEROOT/{tmp,targz} && \
    /bin/mkdir $MYSITEROOT/{tmp,targz}

## create lhcb user to run lhcb software
## add lhcb user to sudoers
RUN useradd -ms /bin/bash lhcb && \
    echo 'lhcb ALL=(ALL)  NOPASSWD:ALL' >> /etc/sudoers

## switch to lhcb user
USER lhcb
ENV USER lhcb
ENV HOME /home/$USER
RUN /bin/mkdir -p $HOME/run

WORKDIR $HOME

## add files last (as this invalids caches)
ADD dot-pythonrc.py  $HOME/.pythonrc.py
ADD dot-bashrc       $HOME/.bashrc

## make the whole container seamlessly executable
ENTRYPOINT ["/bin/bash"]

## EOF

