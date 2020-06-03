##
## hepsw/cvmfs-base
## A container where CernVM-FS is up and running
##
FROM hepsw/cc7-base
LABEL maintainer="Sebastien Binet <binet@cern.ch>"

USER root
ENV USER root
ENV HOME /root
ENV CUBIED_VERSION 20160205

## make sure FUSE can be enabled
RUN if [[ ! -e /dev/fuse ]]; then mknod -m 666 /dev/fuse c 10 229; fi

# install cvmfs repos
ADD etc-yum-cernvm.repo /etc/yum.repos.d/cernvm.repo

# Install rpms
RUN yum update -y && yum install -y \
    cvmfs cvmfs-auto-setup cvmfs-config-default \
	csh \
    freetype fuse \
    glibc-headers \
    man nano openssh-server openssl098e libXext libXpm \
	tcsh time \
	zsh \
    ; \
    yum clean -y all

RUN mkdir -p \
    /cvmfs/cernvm-prod.cern.ch \
    /cvmfs/sft.cern.ch \
	/etc/cubie.d

RUN echo "cernvm-prod.cern.ch /cvmfs/cernvm-prod.cern.ch cvmfs defaults 0 0" >> /etc/fstab && \
    echo "sft.cern.ch         /cvmfs/sft.cern.ch cvmfs defaults 0 0" >> /etc/fstab

WORKDIR /root

## add files last (as this invalids caches)
ADD https://github.com/hepsw/cubie/releases/download/${CUBIED_VERSION}/cubied /usr/bin/cubied
ADD dot-pythonrc.py  $HOME/.pythonrc.py

ADD etc-cvmfs-default-local /etc/cvmfs/default.local
ADD etc-cvmfs-domain-local  /etc/cvmfs/domain.d/cern.ch.local
ADD etc-cvmfs-keys          /etc/cvmfs/keys

ADD etc-cubied-cvmfs.conf /etc/cubie.d/cvmfs.conf
ADD run-cvmfs.sh /etc/cvmfs/run-cvmfs.sh

RUN chmod uga+rx \
	/etc/cvmfs/run-cvmfs.sh \
	/usr/bin/cubied \
	;

## make the whole container seamlessly executable
ENTRYPOINT ["/usr/bin/cubied"]
CMD ["bash"]

## EOF
