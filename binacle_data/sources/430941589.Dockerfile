##
## hepsw/cvmfs-lsst
## A container where CernVM-FS is up and running
##
FROM hepsw/cvmfs-base
MAINTAINER Sebastien Binet "binet@cern.ch"

USER root
ENV USER root
ENV HOME /root
ENV VO_LSST_SW_DIR       /cvmfs/lsst.in2p3.fr

## make sure FUSE can be enabled
RUN if [[ ! -e /dev/fuse ]]; then mknod -m 666 /dev/fuse c 10 229; fi

WORKDIR /root

RUN mkdir -p /etc/cvmfs/keys && \
    mkdir -p /cvmfs/lsst.in2p3.fr && \
    echo "lsst.in2p3.fr /cvmfs/lsst.in2p3.fr cvmfs defaults 0 0" >> /etc/fstab

ADD dot-bashrc              $HOME/.bashrc
ADD lsst-default-local      /etc/cvmfs/default.local
ADD https://github.com/airnandez/lsst-cvmfs/raw/master/lsst.in2p3.fr.conf \
    /etc/cvmfs/config.d/lsst.in2p3.fr.conf
ADD https://github.com/airnandez/lsst-cvmfs/raw/master/lsst.in2p3.fr.pub \
    /etc/cvmfs/keys/lsst.in2p3.fr.pub

RUN chmod 0444 /etc/cvmfs/keys/lsst.in2p3.fr.pub && \
    chmod 0644 \
     /etc/cvmfs/default.local \
     /etc/cvmfs/config.d/lsst.in2p3.fr.conf

## make the whole container seamlessly executable
ENTRYPOINT ["/usr/bin/cubied"]
CMD ["bash"]

## EOF

