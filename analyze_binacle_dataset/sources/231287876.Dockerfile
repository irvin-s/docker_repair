FROM strato-build

ENV LDFLAGS -s
RUN wget -P /usr/src/ https://www.kernel.org/pub/linux/utils/boot/syslinux/6.xx/syslinux-6.03.tar.xz
RUN cd /usr/src/ && tar xf syslinux*
RUN cd /usr/src/syslinux* \
    && make

RUN cd /usr/src/syslinux* \
    && make install
