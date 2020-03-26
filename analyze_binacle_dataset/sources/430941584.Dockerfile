##
## hepsw/cvmfs-lhcb
## A container where CernVM-FS is up and running
##
FROM hepsw/cvmfs-base
MAINTAINER Sebastien Binet "binet@cern.ch"

USER root
ENV USER root
ENV HOME /root
ENV VO_LHCB_SW_DIR /cvmfs/lhcb.cern.ch
ENV MYSITEROOT     /cvmfs/lhcb.cern.ch/lib

## make sure FUSE can be enabled
RUN if [[ ! -e /dev/fuse ]]; then mknod -m 666 /dev/fuse c 10 229; fi

WORKDIR /root

RUN mkdir -p /cvmfs/lhcb.cern.ch && \
    echo "lhcb.cern.ch /cvmfs/lhcb.cern.ch cvmfs defaults 0 0" >> /etc/fstab

ADD etc-cvmfs-lhcb-local    /etc/cvmfs/config.d/lhcb.cern.ch.local
ADD dot-bashrc              $HOME/.bashrc

## make the whole container seamlessly executable
ENTRYPOINT ["/usr/bin/cubied"]
CMD ["bash"]

## EOF

