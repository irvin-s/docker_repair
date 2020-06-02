FROM strato-build

ENV VERSION 1.7
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://downloads.sourceforge.net/acpiclient/acpi-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf acpi*
RUN cd /usr/src/acpi* \
    && ./configure --prefix=/usr \
    && make

RUN cd /usr/src/acpi* \
    && make install
