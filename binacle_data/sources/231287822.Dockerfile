FROM strato-build

ENV LDFLAGS -s
RUN wget -P /usr/src/ https://busybox.net/downloads/busybox-1.25.1.tar.bz2
COPY .config /usr/src/
RUN cd /usr/src/ && tar xf busybox*
RUN cd /usr/src/busybox* \
    && mv ../.config ./ \
    && make silentoldconfig \
    && make

RUN cd /usr/src/busybox* \
    && install -m 755 busybox /bin/busybox \
    && cd / \
    && for i in $(busybox --list-full); do [ -e $i ] && busybox rm $i; busybox ln -s /bin/busybox $i; done
