##
## hepsw/cvmfs-cms
## A container where CernVM-FS is up and running
##
FROM hepsw/cvmfs-base-cc7
LABEL maintainer="Patrick Gartung <gartung@fnal.gov>"

USER root
ENV USER root
ENV HOME /root
ENV VO_CMS_SW_DIR       /cvmfs/cms.cern.ch
ENV CMS_LOCAL_ROOT_BASE /cvmfs/cms.cern.ch

## make sure FUSE can be enabled
RUN if [[ ! -e /dev/fuse ]]; then mknod -m 666 /dev/fuse c 10 229; fi

WORKDIR /root

RUN mkdir -p /cvmfs/cms.cern.ch && \
    echo "cms.cern.ch /cvmfs/cms.cern.ch cvmfs defaults 0 0" >> /etc/fstab

ADD dot-bashrc              $HOME/.bashrc

## make the whole container seamlessly executable
ENTRYPOINT ["/usr/bin/cubied"]
CMD ["bash"]

## EOF
