##
## hepsw/cvmfs-lz
## A container where CernVM-FS is up and running
##
FROM hepsw/cvmfs-base-cc7
LABEL maintainer="Luke Kreczko <kreczko@cern.ch>"

USER root
ENV USER root
ENV HOME /root
ENV VO_LZ_SW_DIR       /cvmfs/lz.opensciencegrid.org
ENV LZ_LOCAL_ROOT_BASE /cvmfs/lz.opensciencegrid.org

## make sure FUSE can be enabled
RUN if [[ ! -e /dev/fuse ]]; then mknod -m 666 /dev/fuse c 10 229; fi

WORKDIR /root

RUN mkdir -p /cvmfs/lz.opensciencegrid.org && \
    echo "lz.opensciencegrid.org /cvmfs/lz.opensciencegrid.org cvmfs defaults 0 0" >> /etc/fstab

ADD dot-bashrc              $HOME/.bashrc

## make the whole container seamlessly executable
ENTRYPOINT ["/usr/bin/cubied"]
CMD ["bash"]

## EOF
