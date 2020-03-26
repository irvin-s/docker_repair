##
## hepsw/cvmfs-atlas
## A container where CernVM-FS is up and running
##
FROM hepsw/cvmfs-base
MAINTAINER Sebastien Binet "binet@cern.ch"

USER root
ENV USER root
ENV HOME /root
ENV VO_ATLAS_SW_DIR       /cvmfs/atlas.cern.ch
ENV ATLAS_LOCAL_ROOT_BASE $VO_ATLAS_SW_DIR/repo/ATLASLocalRootBase

## make sure FUSE can be enabled
RUN if [[ ! -e /dev/fuse ]]; then mknod -m 666 /dev/fuse c 10 229; fi

WORKDIR /root

RUN mkdir -p /cvmfs/atlas.cern.ch && \
    mkdir -p /cvmfs/atlas-condb.cern.ch && \
    echo "atlas.cern.ch /cvmfs/atlas.cern.ch cvmfs defaults 0 0" >> /etc/fstab && \
    echo "atlas-condb.cern.ch /cvmfs/atlas-condb.cern.ch cvmfs defaults 0 0" >> /etc/fstab

ADD dot-bashrc              $HOME/.bashrc

## make the whole container seamlessly executable
ENTRYPOINT ["/usr/bin/cubied"]
CMD ["bash"]

## EOF

