FROM strato-build

ENV VERSION 3.4
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://www.kernel.org/pub/linux/utils/raid/mdadm/mdadm-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf mdadm*
RUN cd /usr/src/mdadm* \
    && make

RUN cd /usr/src/mdadm* \
    && make install
