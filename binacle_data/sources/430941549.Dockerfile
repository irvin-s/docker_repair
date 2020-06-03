##
## hepsw/alice-fair
## A container where all dependencies for FairRoot development are
## installed.
##
FROM hepsw/alice-base
MAINTAINER Sebastien Binet "binet@cern.ch"

USER root
ENV USER root
ENV HOME /root
#ENV PYTHONSTARTUP=$HOME/.pythonrc.py
#ENV SIMPATH=/opt/alice/sw/externals
ENV PATH=/opt/alice/sw/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/alice/sw/lib:$LD_LIBRARY_PATH

RUN git clone git://github.com/FairRootGroup/FairRoot /build/fair-root && \
	mkdir -p /build/build-fair && \
	cd /build/build-fair && \
	cmake -DCMAKE_INSTALL_PREFIX=/opt/alice/sw /build/fair-root && \
	make && \
	make install && \
	/bin/rm -rf /build

RUN echo "## FairRoot config\n\n. /opt/alice/sw/bin/FairRootConfig.sh\n" >> /root/.bashrc

WORKDIR /opt/alice

## make the whole container seamlessly executable
ENTRYPOINT ["/usr/bin/cubied"]
CMD ["bash"]

## EOF

